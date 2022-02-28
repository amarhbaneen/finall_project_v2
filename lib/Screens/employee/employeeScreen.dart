import 'package:finall_project_v2/Screens/employee/employeeHomeScreen.dart';
import 'package:finall_project_v2/Screens/employee/sidedrawer.dart';
import 'package:finall_project_v2/Screens/general/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class employee extends StatefulWidget {
  const employee({Key? key}) : super(key: key);

  @override
  State<employee> createState() => _employeeState();
}

class _employeeState extends State<employee> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: employeeHomePage()
      ),
    );
  }
}
