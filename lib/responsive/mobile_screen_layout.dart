import 'package:finall_project_v2/Screens/general/login.dart';
import 'package:flutter/material.dart';

import '../Screens/Home.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Home(),
      ),
    );
  }
}
