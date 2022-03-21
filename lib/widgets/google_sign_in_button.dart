import 'package:anihub_flutter/utils/constants.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final Function() onGoogleLogin;

  const GoogleSignInButton({
    Key? key,
    required this.onGoogleLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.teal[500],
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30.0,
              width: 30.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(googleLogoAbsolutePath),
                    fit: BoxFit.cover),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Text("Sign In with Google")
          ],
        ),

        // by onpressed we call the function signup function
        onPressed: onGoogleLogin);
  }
}
