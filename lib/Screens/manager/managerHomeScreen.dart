import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/manager/employeeListView.dart';
import 'package:finall_project_v2/Screens/employee/sidedrawer.dart';
import 'package:finall_project_v2/Screens/manager/payCheckManagerScreen.dart';
import 'package:finall_project_v2/Screens/manager/paycheck/PDFVirewePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/demensions.dart';
import '../general/login.dart';

class managerHomeScreen extends StatefulWidget {
  const managerHomeScreen({Key? key}) : super(key: key);

  @override
  _managerHomeScreenState createState() => _managerHomeScreenState();
}

class _managerHomeScreenState extends State<managerHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  String widgetName = 'manager';
  String _firstname = '';
  String _lastname = '';

  String _username = '';
  String _type = '';

  Future<void> _getdata() async {
    final user =
        await _userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
    setState(() {
      _firstname = user['firstname'];
      _lastname = user['lastname'];
      _type = user['type'];
      _username = user['username'];
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
      drawer: SideDrawer(widgetName),
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: ButtonTheme(
            child: ButtonBar(
              alignment:  MainAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Icon(Ionicons.menu_sharp),
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
          Expanded(
              child:MediaQuery.of(context).size.width > webScreenSize ? WebView() : ListView(
                padding:  MediaQuery.of(context).size.width > webScreenSize  ?  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/2.5):const EdgeInsets.only(right: 20, left: 20),
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
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1560420025-9453f02b4751?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=701&q=80'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'WeekSchedule',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'view employee weekly Schedule',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => employeeListView(_username)));
                },
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1549637642-90187f64f420?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1474&q=80'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Employees',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'view employees list',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => pdfViewer()));
                },
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1600007283728-22abc97b9318?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'PayCheck',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'view Paycheck',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1633613286848-e6f43bbafb8d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Problem?',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'report a problem ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Fluttertoast.showToast(msg: "Logged Out");
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LogIn()));
                },
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1646085401455-f659a7220028?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget WebView(){
    return Column(

      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/3.5),
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
        Expanded(
          child: GridView.count(crossAxisCount: 4,
           padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/3.5),
           children: [
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1560420025-9453f02b4751?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=701&q=80'),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'WeekSchedule',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'view employee weekly Schedule',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => employeeListView(_username)));
            },
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1549637642-90187f64f420?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1474&q=80'),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Employees',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'view employees list',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => pdfViewer()));
            },
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1600007283728-22abc97b9318?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'PayCheck',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'view Paycheck',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1633613286848-e6f43bbafb8d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Problem?',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'report a problem ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Fluttertoast.showToast(msg: "Logged Out");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LogIn()));
            },
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1646085401455-f659a7220028?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80'),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
          ),
          ]
          ),
        )
      ],

    );


  }
}
