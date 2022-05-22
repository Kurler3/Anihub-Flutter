import 'package:anihub_flutter/back_end_methods/auth_methods.dart';

import 'package:anihub_flutter/providers/user_provider.dart';
import 'package:anihub_flutter/screens/auth/loading_screen.dart';
import 'package:anihub_flutter/screens/auth/login_screen.dart';
import 'package:anihub_flutter/screens/home/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void initState() {
    super.initState();

    // FETCH USER DETAILS AND UPDATE THE PROVIDER VALUE.
    Provider.of<UserProvider>(context, listen: false).fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    // User? loggedUser = Provider.of<UserProvider>(context).getUser;

    return StreamBuilder(
      stream: AuthMethods().userChanges,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Some error occurred"),
            );
          } else if (!snapshot.hasData) {
            return const LoginScreen();
          } else {
            return const MainScreen();
          }
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
