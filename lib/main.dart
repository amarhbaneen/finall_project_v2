import 'package:finall_project_v2/responsive/mobile_screen_layout.dart';
import 'package:finall_project_v2/responsive/responsive_layout_screen.dart';
import 'package:finall_project_v2/responsive/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Home.dart';


void main() async
{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graphica_APP',
      theme: ThemeData(),
      home: RespsiveLayout(mobileScreenLayout: MobileScreenLayout() , webScreenLayout: WebScreenLayout()),
      debugShowCheckedModeBanner: false,
    );
  }
}