import 'package:anihub_flutter/back_end_methods/auth_methods.dart';
import 'package:anihub_flutter/screens/auth/register_screen.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/utils/functions.dart';
import 'package:anihub_flutter/widgets/common_elevated_button.dart';
import 'package:anihub_flutter/widgets/common_input.dart';
import 'package:anihub_flutter/widgets/google_sign_in_button.dart';
import 'package:anihub_flutter/widgets/rotating_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogoRotating = true;

  bool _isPasswordVisible = false;

  bool _isLoading = false;

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
      setState(() {
        _isLoading = true;
      });

      // CALL FUNCTION IN AUTHMETHODS CLASS
      String logInResult = await AuthMethods().signIn(
          email: _emailController.text, password: _passwordController.text);

      setState(() {
        _isLoading = false;
      });

      if (logInResult != SUCCESS_VALUE) {
        showFlushBar(
          context: context,
          title: 'Something wrong happened',
          message: logInResult,
        );
      }
    } else {
      // Show snackbar :)
      showFlushBar(
        title: "Invalid Input",
        context: context,
        message: "Email or password data incorrect.",
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

  // GOOGLE LOG IN
  onGoogleLogin() async {
    setState(() {
      _isLoading = true;
    });

    String result = await AuthMethods().signInWithGoogle();

    if (result != SUCCESS_VALUE) {
      setState(() {
        _isLoading = false;
      });

      showFlushBar(
        context: context,
        title: 'Some error occurred :(',
        background: badRed,
        // message: result,
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
                            height: 10,
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
                                    keyboardType: TextInputType.emailAddress,
                                    prefixWidget: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.email,
                                        color: iconColor,
                                        size: 26,
                                      ),
                                    ),
                                    hintText: "Enter your email",
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // PASSWORD FORM FIELD
                                  CommonInput(
                                    maxLines: 1,
                                    controller: _passwordController,
                                    isVisible: _isPasswordVisible,
                                    prefixWidget: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: iconColor,
                                        size: 26,
                                      ),
                                    ),
                                    hintText: 'Enter your password',
                                    suffixWidget: InkWell(
                                      onTap: () => setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      }),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(!_isPasswordVisible
                                            ? FontAwesomeIcons.eyeSlash
                                            : FontAwesomeIcons.eye),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: CommonElevatedButton(
                                      buttonChild: _isLoading
                                          ? const CircularProgressIndicator(
                                              color: mainOrange,
                                            )
                                          : const Text("Login"),
                                      onPress: onLoginClicked,
                                      backgroundColor: buttonBackgroundColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // GOOGLE SIGN IN
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: GoogleSignInButton(
                                        onGoogleLogin: onGoogleLogin),
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
