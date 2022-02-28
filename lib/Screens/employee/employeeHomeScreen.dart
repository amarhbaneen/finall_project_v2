import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/employee/sidedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../general/login.dart';

class employeeHomePage extends StatefulWidget {
  @override
  _employeeHomePageState createState() => _employeeHomePageState();
}

class _employeeHomePageState extends State<employeeHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String widgetName = 'employee';

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideDrawer(),
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: ButtonTheme(
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Icon(
                    Icons.list,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  elevation: 0,
                  color: Colors.transparent,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2.0,
                  color: Colors.white,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                )
              ]),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 150.0),
      ),
      body:Column(
        children: [
          Container(
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("welcome back "),
              subtitle: Text("user"),
              trailing: Icon(Icons.monitor_heart_outlined),
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                tileColor: Colors.blue.withAlpha(30),
            ),
          ),
          Expanded(


          child: GridView.count( crossAxisCount: 2, children:[
                GridTile(
                  child: Card(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        // Navigator.push//
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        width: 250,
                        height: 75,
                        child: Center(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.event,
                                  size: 60.0,
                                ),
                                Text("Week Schedule")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GridTile(
                  child: Card(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    // Navigator.push//
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white)),
                    width: 250,
                    height: 75,
                    child: Center(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.payments_outlined,
                              size: 60.0,
                            ),
                            Text("Pay Check")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                  ),
                ),
                GridTile(
                  child: Card(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        // Navigator.push//
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        width: 250,
                        height: 75,
                        child: Center(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.report_gmailerrorred,
                                  size: 60.0,
                                ),
                                Text("Report")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GridTile(
                  child: Card(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Fluttertoast.showToast(msg: "Logged Out");
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => LogIn()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        width: 250,
                        height: 75,
                        child: Center(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.exit_to_app,
                                  size: 60.0,
                                ),
                                Text("logout")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          ])
          )]),
        );
  }
}
