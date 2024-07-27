import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:job_findder_app/screens/admin/admin.dart';
import 'package:job_findder_app/screens/auth/screens/otp_screen.dart';
import 'package:job_findder_app/screens/client/recomended_screen.dart';

import '../../client/home.dart';
import '/provider/userProvider.dart';
import '/screens/auth/screens/login.dart';

import '/constants/error_handling.dart';
import '../../../constants/appColors.dart';
import '/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String generateOtp(int length) {
    final random = Random();
    final otp = List.generate(length, (index) => random.nextInt(10)).join();
    return otp;
  }

  void sendOtp(
      {required BuildContext context,
      required VoidCallback onSuccess,
      required VoidCallback onError,
      required String email}) async {
    try {
      String otp = generateOtp(6);

      http.Response res = await http.post(
        Uri.parse('$uri/api/users/generate-otp/'),
        body: jsonEncode({'email': email, 'otp': otp}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode != 200) {
        onError();
      }
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setString('otp', otp);
            onSuccess();
          },
        );
      }
    } catch (e) {
      onError();
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }
  }

  // sign up user
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String phone,
      required String sex,
      required String city,
      required String country,
      required VoidCallback onSuccess,
      required VoidCallback onError}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      // print(user.token);
      http.Response res = await http.post(
        Uri.parse('$uri/api/users/'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'sex': sex,
          'city': city,
          'country': country,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );

      if (kDebugMode) {
        print(res.statusCode);
        print(res.body);
      }

      if (res.statusCode != 201) {
        onError();
      }
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setString('email', email);
            onSuccess();
          },
        );
      }
    } catch (e) {
      onError();
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }
  }

  // sign in user
  void signInUser(
      {required BuildContext context,
      required String email,
      required String password,
      required VoidCallback onError}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/users/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode != 200) {
        onError();
      }
      if (kDebugMode) {
        print(res.statusCode);
        print(res.body);
      }
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            await prefs.setString('otp', '');
            await prefs.setString('jobId', jsonDecode(res.body)['_id']);
            await prefs.setString('jobToken', jsonDecode(res.body)['token']);

            if (context.mounted) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(res.body);
              var userProvider =
                  Provider.of<UserProvider>(context, listen: false);

              bool isAdmin = jsonDecode(res.body)['isAdmin'];

              if (!isAdmin) {
                if (userProvider.user.categories == []) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RecomendedJobsScreen.routeName,
                    (route) => false,
                  );
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Home.routeName,
                    (route) => false,
                  );
                }
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AdminScreen.routeName,
                  (route) => false,
                );
              }
            }
          },
        );
      }
    } catch (e) {
      onError();
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('jobId', '');
      await sharedPreferences.setString('jobToken', '');
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }
  }

  void updateUserProfile(
      {required BuildContext context,
      required String email,
      required String name,
      required String phone,
      required String city,
      required String country,
      required VoidCallback onSucc}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.put(
        Uri.parse('$uri/api/users/profile/${user.id}'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'city': city,
          'country': country,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );
      if (res.statusCode != 200) {
        onSucc();
      }

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account Updated! Login with the same credentials!');

            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }
  }

  void updateUserPassword(
      {required BuildContext context,
      required String password,
      required VoidCallback onSucc}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.put(
        Uri.parse('$uri/api/users/update/passwors/${user.id}'),
        body: jsonEncode({
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );
      if (res.statusCode != 200) {
        onSucc();
      }

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account Updated! Login with the same credentials!');

            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String otp = prefs.getString('otp') ?? '';
      String? id = prefs.getString('jobId') ?? '';
      String? token = prefs.getString('jobToken') ?? '';

      print(otp);

      if (otp == '') {
        if (token != '') {
          var tokenRes = await http.post(
            Uri.parse('$uri/api/users/profile/$id'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': 'Bearer $token',
            },
            body: jsonEncode({
              'token': token,
            }),
          );

          // print(tokenRes.body);
          // print(tokenRes.statusCode);

          if (context.mounted) {
            httpErrorHandle(
                response: tokenRes,
                context: context,
                onSuccess: () async {
                  userProvider.setUser(tokenRes.body);
                  if (!userProvider.user.isAdmin) {
                    if (userProvider.user.categories!.isEmpty) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          RecomendedJobsScreen.routeName, (route) => false);
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Home.routeName, (route) => false);
                    }
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AdminScreen.routeName, (route) => false);
                  }
                });
          }
        } else {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) => const LoginScreen())),
                (route) => false);
          }
        }
      } else {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => const OtpScreen())),
              (route) => false);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) => const LoginScreen())),
            (route) => false);
      }
    }
  }
}
