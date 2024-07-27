// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:job_findder_app/screens/auth/screens/login.dart';
import 'package:job_findder_app/screens/auth/widgets/custom_textField_2.dart';
import '../../../constants/appColors.dart';
import '../../../constants/utils.dart';
import 'package:country_picker/country_picker.dart';

import '../services/auth_services.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/singup';
  final String? email;
  const RegisterScreen({
    Key? key,
    this.email,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();
  final AuthService authService = AuthService();
  final _signInFormKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool isLoging = false;
  bool isMale = false;
  bool isFemaleMale = false;
  String sex = '';

  Country selectedCountry = Country(
    phoneCode: "252",
    countryCode: "SO",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "so",
    example: "so",
    displayName: "Somalia",
    displayNameNoCountryCode: "Somalia (SO)",
    e164Key: "",
  );

  Country selectedCountryPhoneCode = Country(
    phoneCode: "252",
    countryCode: "SO",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "so",
    example: "so",
    displayName: "so",
    displayNameNoCountryCode: "SO",
    e164Key: "",
  );

  void singUp() {
    if (_signInFormKey.currentState!.validate() && sex != '') {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailcontroller.text)) {
        setState(() {
          isLoging = true;
        });
        authService.signUpUser(
            context: context,
            name: namecontroller.text,
            email: emailcontroller.text,
            password: passcontroller.text,
            phone: selectedCountryPhoneCode.phoneCode + phonecontroller.text,
            city: citycontroller.text,
            country: selectedCountry.displayNameNoCountryCode,
            sex: sex,
            onSuccess: () {
              authService.sendOtp(
                  context: context,
                  onSuccess: () {
                    showSnackBar(context, 'OTP sent successfully');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        OtpScreen.routeName,
                        arguments: emailcontroller.text,
                        (route) => false);
                  },
                  onError: () {
                    showSnackBar(context, 'OTP not sent, please try again');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        OtpScreen.routeName,
                        arguments: emailcontroller.text,
                        (route) => false);
                  },
                  email: emailcontroller.text);
            },
            onError: (() {
              setState(() {
                isLoging = false;
              });
            }));
      } else {
        showSnackBar(context, 'Enter a valid email');
      }
    } else {
      showSnackBar(context, 'All information are required');
    }
  }

  @override
  void initState() {
    if (widget.email != null) {
      emailcontroller.text = widget.email!;
    }

    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: FittedBox(
                        child: Text(
                          'Welcome Back',
                          maxLines: 1,
                          style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Center(
                      child: FittedBox(
                        child: Text(
                          'Signin to countinue',
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 11,
                child: SingleChildScrollView(
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField2(
                          controller: namecontroller,
                          hintText: 'Full name',
                          icon: Icons.person_3,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField2(
                            controller: emailcontroller,
                            hintText: 'Email address',
                            icon: Icons.email),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField2(
                            controller: phonecontroller,
                            hintText: 'Phone Number',
                            icon: Icons.phone),
                        const SizedBox(
                          height: 12,
                        ),
                        _buildSexOptions(),
                        const SizedBox(
                          height: 12,
                        ),
                        _buildCountryPicker(context, screenH),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          style: const TextStyle(color: AppColors.primarycolor),
                          controller: passcontroller,
                          obscureText: !_passwordVisible,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is required!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 0.01),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                    color: AppColors.secondaryColor)),
                            filled: true,
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.password,
                              color: AppColors.secondaryColor,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.secondaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        isLoging
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: singUp,
                                child: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    'SingUp',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                            TextButton(
                              onPressed: () {
                                isLoging
                                    ? () {}
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const LoginScreen())));
                              },
                              child: const Text('SingIn here',
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildCountryPicker(BuildContext context, double screenH) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(color: AppColors.primarycolor),
            controller: citycontroller,
            keyboardType: TextInputType.streetAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'city is required!';
              }
              return null;
            },
            decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 0.01),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        const BorderSide(color: AppColors.secondaryColor)),
                filled: true,
                fillColor: Colors.white,
                hintText: 'City',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                prefixIcon: const Icon(
                  Icons.location_city,
                  color: AppColors.secondaryColor,
                )),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.white),
            child: TextButton(
              style: TextButton.styleFrom(alignment: Alignment.topLeft),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  '${selectedCountry.flagEmoji} ${selectedCountry.displayNameNoCountryCode}',
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              onPressed: () {
                showCountryPicker(
                    context: context,
                    countryListTheme: CountryListThemeData(
                      bottomSheetHeight: screenH * 0.6,
                    ),
                    onSelect: (value) {
                      setState(() {
                        selectedCountry = value;
                      });
                    });
              },
            ),
          ),
        ),
      ],
    );
  }

  Container _buildSexOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Sex:'),
          Row(
            children: [
              Row(
                children: [
                  Checkbox(
                      value: isMale,
                      onChanged: (val) {
                        setState(() {
                          isFemaleMale = false;
                          isMale = val!;
                          if (val == true) {
                            sex = 'Male';
                          } else {
                            sex = '';
                          }
                        });
                      }),
                  const Text('Male')
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isFemaleMale,
                      onChanged: (val) {
                        setState(() {
                          isMale = false;
                          isFemaleMale = val!;
                          if (val == true) {
                            sex = 'Female';
                          } else {
                            sex = '';
                          }
                        });
                      }),
                  const Text('Female')
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
