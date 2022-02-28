import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/general/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'employeeScreen.dart';

class SideDrawer  extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  String? currentemail = FirebaseAuth.instance.currentUser?.email;
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('users');
  String? _username =  '';
  Future<String?> _getdata() async{
    final user = await _userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
    setState(() {
      _username = user['username'];


    });
    return _username;
  }
  @override
  initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          decoration: BoxDecoration(
            // Box decoration takes a gradient
          ),
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black
                ),
                accountEmail: Text(currentemail!),
                accountName: Text('hey $_username'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: AssetImage("Assets/photo-1554224154-22dec7ec8818.jpeg"),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => employee()));
                },
              ),
              ListTile(
                onTap: () {
                  //Navigator//
                },
                leading: Icon(Icons.event),
                title: Text("Week Schedule"),
              ),
              ListTile(
                  leading: Icon(Icons.payments_outlined),
                  title: Text("Pay Check"),
                  onTap: () {
                    //Navigator//
                  }),
              ListTile(
                  leading: Icon(Icons.report_gmailerrorred),
                  title: Text("Report"),
                  onTap: () {
                    //Navigator//
                  }),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Fluttertoast.showToast(msg: "Logged Out");
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LogIn()));
                },
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
              ),
            ],
          ),
        ));
  }
}