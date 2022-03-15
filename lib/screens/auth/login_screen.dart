import 'package:anihub_flutter/screens/auth/register_screen.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/utils/functions.dart';
import 'package:anihub_flutter/widgets/common_elevated_button.dart';
import 'package:anihub_flutter/widgets/common_input.dart';
import 'package:anihub_flutter/widgets/rotating_image.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogoRotating = true;

  // FORM KEY
  final _formKey = GlobalKey<FormState>();

  // EMAIL INPUT CONTROLLER
  final TextEditingController _emailController = TextEditingController();

  // PASSWORD INPUT CONTROLLER
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();

    _passwordController.dispose();
  }

  onSignUpClicked() {
    Navigator.of(context)
        .push(createRegisterRouteLeftRight(const RegisterScreen()));
  }

  onLoginClicked() async {
    if (_emailController.text.isNotEmpty &&
        isEmailValid(_emailController.text) &&
        _passwordController.text.length >= 6) {
      // CALL FUNCTION IN AUTHMETHODS CLASS

    } else {
      // Show snackbar :)
      showFlushBar(
        title: "Invalid Input",
        context: context,
        message: "Email or password data incorrect.",
        // mainButton: CommonElevatedButton(
        //   buttonChild: const Icon(Icons.close),
        //   onPress: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: blue,
        icon: Icon(
          Icons.info_outline,
          size: 28,
          color: Colors.blue.shade300,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // OUTER CONTAINER (FULL SCREEN)
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          // PADDING OF INNER CHILD
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CommonElevatedButton(
                                backgroundColor:
                                    _isLogoRotating ? badRed : mainOrange,
                                buttonChild: const Icon(
                                  Icons.stop,
                                  color: iconColor,
                                  size: 30,
                                ),
                                onPress: () {
                                  setState(() {
                                    _isLogoRotating = !_isLogoRotating;
                                  });
                                },
                              ),
                            ),
                          ),
                          // APP LOGO
                          RotatingImage(
                            isRotating: _isLogoRotating,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Image.asset(
                                appLogoAbsolutePath,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // FORM CONTAINER
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: MediaQuery.of(context).viewInsets,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // EMAIL FORM FIELD
                                  CommonInput(
                                    maxLines: 1,
                                    controller: _emailController,
                                    prefixWidget: const Padding(
                                      padding: EdgeInsets.only(bottom: 4.0),
                                      child: Icon(
                                        Icons.email,
                                        color: iconColor,
                                      ),
                                    ),
                                    // label: const Text('Email'),
                                    hintText: "Enter your email",
                                    validatorFunction: (value) {
                                      // if (value == null || value.isEmpty) {
                                      //   return 'Please enter some text';
                                      // } else if (!isEmailValid(value)) {
                                      //   return 'Please enter a valid email address';
                                      // }
                                      // return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // PASSWORD FORM FIELD
                                  CommonInput(
                                    maxLines: 1,
                                    controller: _passwordController,
                                    prefixWidget: const Padding(
                                      padding: EdgeInsets.only(bottom: 4.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: iconColor,
                                      ),
                                    ),
                                    // label: const Text('Password'),
                                    hintText: 'Enter your password',
                                    // validatorFunction: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please a password';
                                    //   } else if (value.length < 6) {
                                    //     return 'Password needs to be at least 6 characters long';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: CommonElevatedButton(
                                      buttonChild: const Text("Login"),
                                      onPress: onLoginClicked,
                                      backgroundColor: buttonBackgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(),
                            flex: 1,
                          ),

                          Container(
                            margin: MediaQuery.of(context).viewInsets,
                            child: TextButton(
                              onPressed: onSignUpClicked,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: "Don't have an account yet? "),
                                      TextSpan(
                                        text: "Sign up here!",
                                        style: TextStyle(
                                          color: blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
