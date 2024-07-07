import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../constants/error_handling.dart';
import '../../../../constants/appColors.dart';
import '../../../../constants/utils.dart';
import '../../../../provider/userProvider.dart';

class AccountServices {
  void updateUserBio(
      {required BuildContext context,
      required String bio,
      required VoidCallback onError}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.put(
        Uri.parse('$uri/api/users/app/bio/${user.id}'),
        body: jsonEncode({
          'bio': bio,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );

      print(res.statusCode);
      print(res.body);
      if (res.statusCode != 200) {
        onError();
      }

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                'Updated Successfully!, close the app an reopen again');

            Navigator.pop(context);
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

  void updateUserPreferredCategories(
      {required BuildContext context,
      required String categories,
      required VoidCallback onError}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.put(
        Uri.parse('$uri/api/users/app/update/passwors/${user.id}'),
        body: jsonEncode({
          'categories': categories,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );
      if (res.statusCode != 200) {
        onError();
      }

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                'Updated Successfully!, close the app an reopen again');

            Navigator.pop(context);
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

  void updateuserWorkExperience(
      {required BuildContext context,
      required String title,
      required String category,
      required String employmentType,
      required String companyName,
      required String location,
      required bool currentlyWorking,
      required String startDate,
      required String endDate,
      required String description,
      required VoidCallback onError}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.put(
        Uri.parse('$uri/api/users/app/workExperience/${user.id}'),
        body: jsonEncode({
          "title": title,
          "category": category,
          "employmentType": employmentType,
          "companyName": companyName,
          "location": location,
          "currentlyWorking": currentlyWorking,
          "startDate": startDate,
          "endDate": endDate,
          "description": description,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );

      print(res.statusCode);
      print(res.body);
      if (res.statusCode != 200) {
        onError();
      }

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // var user = Provider.of<UserProvider>(context, listen: false);
            // user.setUser(jsonDecode(res.body));
            showSnackBar(context,
                'Updated Successfully!, close the app an reopen again');

            Navigator.pop(context);
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

  void updateUserEducation(
      {required BuildContext context,
      required String school,
      required String degree,
      required String fieldOfStudy,
      required String startDate,
      required String endDate,
      required String description,
      required VoidCallback onError}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.put(
        Uri.parse('$uri/api/users/app/education/${user.id}'),
        body: jsonEncode({
          "school": school,
          "degree": degree,
          "fieldOfStudy": fieldOfStudy,
          "startDate": startDate,
          "endDate": endDate,
          "description": description
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );

      if (res.statusCode != 200) {
        onError();
      }

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // var user = Provider.of<UserProvider>(context, listen: false);
            // user.setUserFromModel(jsonDecode(res.body));
            showSnackBar(context,
                'Updated Successfully!, close the app an reopen again');

            Navigator.pop(context);
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

  void updateUserCertificates(
      {required BuildContext context,
      required String title,
      required String organization,
      required String issueDate,
      required String certificateUrl,
      required String description,
      required VoidCallback onError}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.put(
        Uri.parse('$uri/api/users/app/certificates/${user.id}'),
        body: jsonEncode({
          "title": title,
          "organization": organization,
          "issueDate": issueDate,
          "certificateUrl": certificateUrl,
          "description": description,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );
      if (res.statusCode != 200) {
        onError();
      }

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                'Updated Successfully!, close the app an reopen again');

            Navigator.pop(context);
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

  void updateUserLanguages(
      {required BuildContext context,
      required String language,
      required String level,
      required VoidCallback onError}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.put(
        Uri.parse('$uri/api/users/app/languages/${user.id}'),
        body: jsonEncode({
          "language": language,
          "level": level,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );
      if (res.statusCode != 200) {
        onError();
      }

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                'Updated Successfully!, close the app an reopen again');

            Navigator.pop(context);
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

  void updateUserSkills(
      {required BuildContext context,
      required String skill,
      required String level,
      required VoidCallback onError}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.put(
        Uri.parse('$uri/api/users/app/skills/${user.id}'),
        body: jsonEncode({
          "skill": skill,
          "level": level,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );
      if (res.statusCode != 200) {
        onError();
      }

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                'Updated Successfully!, close the app an reopen again');

            Navigator.pop(context);
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
}
