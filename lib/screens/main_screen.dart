import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:testing_app/screens/add_screen.dart';
import 'package:testing_app/screens/settings_screen.dart';
import 'package:testing_app/screens/update_client_screen.dart';

import 'list_screen.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  int _currentIndex = 0;
  final screens = const [
    ListScreen(),
    AddScreen(),
    UpdateScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        body: Center(
          child: screens[_currentIndex],
        ),
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.blue,
            color: Colors.white,
            animationDuration: const Duration(milliseconds: 250),
            items: const [
              Icon(
                Icons.home_outlined,
                size: 30.0,
                color: Colors.lightBlue,
              ),
              Icon(
                Icons.add_outlined,
                size: 30.0,
                color: Colors.lightBlue,
              ),
              Icon(
                Icons.update_outlined,
                size: 30.0,
                color: Colors.lightBlue,
              ),
              Icon(
                Icons.settings_outlined,
                size: 30.0,
                color: Colors.lightBlue,
              )
            ],
            onTap: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            }));
  }
}
