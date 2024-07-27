import 'dart:convert';
import 'dart:math';

import 'package:job_findder_app/constants/utils.dart';

import '/screens/auth/screens/login.dart';

import '../../../constants/appColors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../provider/userProvider.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp';

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = '';
  bool isLoading = false;

  String generateOtp(int length) {
    final random = Random();
    final otp = List.generate(length, (index) => random.nextInt(10)).join();
    return otp;
  }

  resendOtp() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isLoading = true;
      });

      String otp = generateOtp(6);
      String email = prefs.getString('email') ?? '';

      http.Response res = await http.post(
        Uri.parse('$uri/api/users/generate-otp/'),
        body: jsonEncode({'email': email, 'otp': otp}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        if (mounted) {
          showSnackBar(
              context, 'OTP sent successfully, please check your email.');
        }

        prefs.setString('otp', otp);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  verify() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String otp = prefs.getString('otp') ?? '';

    if (otp != '' && otp == otpCode) {
      if (mounted) {
        showSnackBar(context, 'Account verified successfully.');
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      prefs.setString('otp', 'verified');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.shade50,
                  ),
                  child: Image.asset(
                    "assets/image2.png",
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Verification",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter the OTP send to your email account",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Pinput(
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onCompleted: (value) {
                    setState(() {
                      otpCode = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      otpCode = value;
                    });
                    print(otpCode.length);
                  },
                ),
                const SizedBox(height: 25),
                isLoading
                    ? const Center(
                        child: RefreshProgressIndicator(
                            color: AppColors.primarycolor),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primarycolor,
                              shape: const StadiumBorder()),
                          onPressed: otpCode.length < 6 ? null : verify,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 18),
                            child: Text(
                              'Verify',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                const Text(
                  "Didn't receive any code?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: isLoading ? null : resendOtp,
                  child: const Text(
                    "Resend New Code",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
