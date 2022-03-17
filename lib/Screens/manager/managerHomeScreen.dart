import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/employee/sidedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ionicons/ionicons.dart';


class managerHomeScreen extends StatefulWidget {
  const managerHomeScreen({Key? key}) : super(key: key);

  @override
  _managerHomeScreenState createState() => _managerHomeScreenState();
}

class _managerHomeScreenState extends State<managerHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('users');
  String widgetName = 'employee';
  String _username = '' ;
  String _type = '';
  Future <void> _getdata()
  async {
    final user = await _userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
    setState(() {
      _username = user['username'];
      _type = user['type'];
    });
  }
  @override
  void initState() {
    super.initState();
    _getdata();
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
                  'Manager Home ',
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
      body: Column(
        children: [
          Container(
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("welcome back $_username "),
              subtitle: Text("$_type"),
              trailing: Icon(Icons.monitor_heart_outlined),
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(20)),
              tileColor: Colors.blue.withAlpha(30),
            ),
          ),
          Expanded(
              child: GridView.count(crossAxisCount: 2 ,  children: [
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
                                  EvaIcons.calendar,
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
                                  EvaIcons.peopleOutline,
                                  size: 60.0,
                                ),
                                Text("employee List")
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
                                  Ionicons.newspaper_outline,
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
              ],)
          )
        ],
      ),
    );
  }
}