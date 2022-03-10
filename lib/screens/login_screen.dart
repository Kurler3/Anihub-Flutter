import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/utils/functions.dart';
import 'package:anihub_flutter/widgets/common_elevated_button.dart';
import 'package:anihub_flutter/widgets/common_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // OUTER CONTAINER (FULL SCREEN)
      body: SizedBox(
        width: double.infinity,
        // PADDING OF INNER CHILD
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
                        const SizedBox(
                          height: 50,
                        ),
                        // APP LOGO
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Image.asset(
                            appLogoAbsolutePath,
                            fit: BoxFit.fill,
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
                                  controller: _emailController,
                                  prefixWidget: const Padding(
                                    padding: EdgeInsets.only(bottom: 4.0),
                                    child: Icon(
                                      Icons.email,
                                      color: iconColor,
                                    ),
                                  ),
                                  label: const Text('Email'),
                                  hintText: "Enter your email",
                                  validatorFunction: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    } else if (!isEmailValid(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // PASSWORD FORM FIELD
                                CommonInput(
                                  controller: _passwordController,
                                  prefixWidget: const Padding(
                                    padding: EdgeInsets.only(bottom: 4.0),
                                    child: Icon(
                                      Icons.lock,
                                      color: iconColor,
                                    ),
                                  ),
                                  label: const Text('Password'),
                                  hintText: 'Enter your password',
                                  validatorFunction: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please a password';
                                    } else if (value.length < 6) {
                                      return 'Password needs to be at least 6 characters long';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: CommonElevatedButton(
                                    buttonChild: const Text("Login"),
                                    onPress: () {
                                      // IF EMAIL AND PASSWORD INPUTS ARE VALIDATED
                                      if (_formKey.currentState!.validate()) {
                                        // CALL SIGN IN FUNCTION
                                      }
                                    },
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
                            onPressed: () {},
                            child: const Text(
                                "Don't have an account yet? Sign up here!"),
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
    );
  }
}
