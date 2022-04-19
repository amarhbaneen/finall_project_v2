import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/employee/employeeHomeScreen.dart';
import 'package:finall_project_v2/Screens/general/login.dart';
import 'package:finall_project_v2/Screens/manager/managerHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../manager/employeeListView.dart';


class SideDrawer  extends StatefulWidget {
  final String widgetName;
  const SideDrawer(this.widgetName);
  @override
  _SideDrawerState createState() => _SideDrawerState();


}

class _SideDrawerState extends State<SideDrawer> {

  String? currentemail = FirebaseAuth.instance.currentUser?.email;
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('users');
  String _username =  '';
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
    print(widget);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.widgetName == 'employee')
        {
          return Drawer(
            child: employeeSideDrawer()
          );
        }
    else
      {
        return Drawer(
            child: managerSideDrawer()
        );
      }


  }

  Widget employeeSideDrawer() {
    return ListView(
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
            backgroundImage: AssetImage(
                "Assets/photo-1554224154-22dec7ec8818.jpeg"),
          ),
        ),

        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => employeeHomePage()));
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
    );
  }
  Widget managerSideDrawer() {
    return ListView(
      padding: EdgeInsets.all(0.0),
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
              color: Colors.black
          ),
          accountEmail: Text(currentemail!),
          accountName: Text('hey $_username'),
        ),

        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => managerHomeScreen()));
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
            leading: Icon(Icons.account_box),
            title: Text("employees"),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => employeeListView(_username)));
            }),
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
    );
  }

}