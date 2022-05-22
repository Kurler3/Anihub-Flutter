import 'package:anihub_flutter/back_end_methods/auth_methods.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  signOut() async {
    AuthMethods().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.logout)),
        ],
      ),
      body: const Center(
        child: Text("PROFILE SCREEN BOI"),
      ),
    );
  }
}
