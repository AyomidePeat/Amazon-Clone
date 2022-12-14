import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_guide/Screens/sign_in_screen.dart';
import 'package:flutter_guide/Widget/custom_primary_widget.dart';
import 'package:flutter_guide/Widget/text_field_widget.dart';
import '../Resources/resources_auth_method.dart';
import '../Utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/amazon logo.png',
                  height: screenSize.height * 0.10,
                ),
                SizedBox(
                  height: screenSize.height * 0.7,
                  child: FittedBox(
                    child: Container(
                      height: screenSize.height * 0.85,
                      width: screenSize.width * 0.5,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sign-Up',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 33),
                          ),
                          TextFieldWidget(
                            title: 'Name',
                            controller: nameController,
                            obscureText: false,
                            hintText: 'Enter Your Name',
                          ),
                          TextFieldWidget(
                            title: 'Address',
                            controller: addressController,
                            obscureText: false,
                            hintText: 'Enter Your Address',
                          ),
                          TextFieldWidget(
                            title: 'Email',
                            controller: emailController,
                            obscureText: false,
                            hintText: 'Enter Your Email',
                          ),
                          TextFieldWidget(
                            title: 'Password',
                            controller: passwordController,
                            obscureText: true,
                            hintText: 'Enter Your Password',
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: CustomMainButton(
                                  child: const Text('Sign in',
                                      style: TextStyle(
                                          letterSpacing: 0.6,
                                          color: Colors.black)),
                                  color: Colors.yellow,
                                  isLoading: isLoading,
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    String output =
                                        await authenticationMethods.signUpUser(
                                            name: nameController.text,
                                            address: addressController.text,
                                            email: emailController.text,
                                            password: passwordController.text);
                                    setState(() {
                                      isLoading = false;
                                    });

                                    if (output == "Success") {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SignInScreen()));
                                    } else {
                                      Utils().showSnackBar(
                                          context: context, content: output);
                                    }
                                  })),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomMainButton(
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        letterSpacing: 0.6,
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.grey[400]!,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SignInScreen();
                      }));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
