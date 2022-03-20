import 'package:anihub_flutter/back_end_methods/auth_methods.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthMethods().signOut();
            },
          )
        ],
      ),
      body: Container(
        child: Center(child: Text('MAIN SCREEN EHEHEH')),
      ),
    );
  }
}
