import 'package:flutter/material.dart';
import 'package:flutter_guide/Resources/resources_auth_method.dart';
import 'package:flutter_guide/Screens/home_screen.dart';
import 'package:flutter_guide/Screens/sign_upScreen.dart';
import 'package:flutter_guide/Widget/custom_primary_widget.dart';
import 'package:flutter_guide/layout/screen_layout.dart';
import 'package:flutter_guide/Widget/text_field_widget.dart';

import '../Utils/utils.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }
   Utils utils = Utils();

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
                Container(
                  height: screenSize.height * 0.6,
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
                        'Sign-in',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 33),
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
                                    letterSpacing: 0.6, color: Colors.black)),
                            color: Colors.yellow,
                            isLoading: isLoading,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              Future.delayed(Duration(seconds: 1));
                              String output =
                                  await authenticationMethods.signInUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                                      setState(() {
                                        isLoading = false;
                                         });
                                      if (output =="success"){
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenLayout()));
                                      }else{
                                        utils.showSnackBar(context: context, content: output);
                                      }
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(height: 1, color: Colors.grey),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'New to Amazon?',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(height: 1, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                CustomMainButton(
                  child: const Text(
                    'Create an Amazon Account',
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
                      return SignUpScreen();
                    }));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
