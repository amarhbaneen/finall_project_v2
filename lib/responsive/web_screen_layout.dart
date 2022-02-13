import 'package:finall_project_v2/Screens/general/login.dart';
import 'package:flutter/material.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LogIn(),
      ),
    );
  }
}
