
import 'package:flutter/material.dart';

import '../Screens/general/login.dart';

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
