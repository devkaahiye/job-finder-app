// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/custom_textField_2.dart';
import '/screens/auth/screens/register.dart';
import '/screens/client/home.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  final String? email;
  const LoginScreen({
    Key? key,
    this.email,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final AuthService authService = AuthService();
  final _signInFormKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool isLoging = false;

  void login() {
    if (_signInFormKey.currentState!.validate()) {
      setState(() {
        isLoging = true;
      });
      authService.signInUser(
          context: context,
          email: emailcontroller.text,
          password: passcontroller.text,
          onError: (() {
            setState(() {
              isLoging = false;
            });
          }));
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
      backgroundColor: GlobalVariables.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 8,
                child: Form(
                  key: _signInFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Shaqadoon',
                          maxLines: 1,
                          style: TextStyle(
                              color: GlobalVariables.secondaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          'Signin to countinue',
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 40),
                        CustomTextField2(
                            controller: emailcontroller,
                            hintText: 'Email address',
                            icon: Icons.email),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: const TextStyle(
                              color: GlobalVariables.primarycolor),
                          controller: passcontroller,
                          obscureText: !_passwordVisible,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid password!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 0.01),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: GlobalVariables.secondaryColor)),
                            filled: true,
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.password,
                              color: GlobalVariables.secondaryColor,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: GlobalVariables.primarycolor,
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
                          height: 20,
                        ),
                        isLoging
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GlobalVariables.secondaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: login,
                                child: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundColor: GlobalVariables.secondaryColor,
                              child: Image.asset(
                                'assets/google.png',
                                width: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundColor: GlobalVariables.secondaryColor,
                              child: Icon(
                                Icons.facebook_sharp,
                                size: 30,
                              ),
                            )
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
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                    TextButton(
                      child: const Text('SingUp',
                          style: TextStyle(
                              color: GlobalVariables.secondaryColor,
                              fontSize: 16)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const RegisterScreen())));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
