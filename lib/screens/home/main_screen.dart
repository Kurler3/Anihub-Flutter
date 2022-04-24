import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onBottomNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: backgroundColor,
      //   // actions: [
      //   //   IconButton(
      //   //     icon: Icon(Icons.logout),
      //   //     onPressed: () async {
      //   //       await AuthMethods().signOut();
      //   //     },
      //   //   )
      //   // ],
      // ),
      body: MAIN_SCREENS.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        elevation: 2.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: mainOrange,
        onTap: _onBottomNavigationItemTapped,
      ),
    );
  }
}
