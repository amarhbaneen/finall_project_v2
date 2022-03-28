import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/employee/sidedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import '../general/login.dart';

class employeeHomePage extends StatefulWidget {
  @override
  _employeeHomePageState createState() => _employeeHomePageState();
}

class _employeeHomePageState extends State<employeeHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String widgetName = 'employee';
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('users');
  String _firstname = '' ;
  String _lastname = '';
  String _type = '' ;
  Future<String?> _getdata() async{
    final user = await _userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
    setState(() {
      _firstname = user['firstname'];
      _type = user['type'];
      _lastname = user['lastname'];
    });}
  @override
  initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideDrawer(widgetName),
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
          Expanded(child:ListView(
            children: [
              Container(
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(Ionicons.person, size: 40),
                    title: Text(
                      "$_firstname $_lastname ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("$_type",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1560420025-9453f02b4751?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=701&q=80'),
                          fit: BoxFit.cover
                      )

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'WeekSchedule',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'view your weekly Schedule',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          NetworkImage('https://images.unsplash.com/photo-1600007283728-22abc97b9318?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                          fit: BoxFit.cover
                      )
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'PayCheck',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'view Paycheck',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          NetworkImage('https://images.unsplash.com/photo-1633613286848-e6f43bbafb8d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                          fit: BoxFit.cover
                      )
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Problem?',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'report a problem ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Fluttertoast.showToast(msg: "Logged Out");
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LogIn()));
                },
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          NetworkImage('https://images.unsplash.com/photo-1646085401455-f659a7220028?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80'),
                          fit: BoxFit.cover
                      )
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    ],
                  ),
                ),
              ),

            ],
          )),
          ]),
        );
  }
}
