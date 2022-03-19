import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/employee/sidedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';

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
  String widgetName = 'employee';
  String _firstname = '';

  String _type = '';

  Future<void> _getdata() async {
    final user =
        await _userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
    setState(() {
      _firstname = user['firstname'];
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
          Container(
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Ionicons.person, size: 40),
                title: Text(
                  "welcome back $_firstname ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("$_type",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: GridView.count(
            crossAxisCount: 2,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: InkWell(
                    onTap: () {},
                    child: Center(
                        child: Text('Week Schedule',
                            style: TextStyle(
                                height: 10,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white)))),
                height: 190.0,
                width: MediaQuery.of(context).size.width - 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage('Assets/images/Header-1024x801.png'),
                        fit: BoxFit.fill)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: InkWell(
                    onTap: () {},
                    child: Center(
                        child: Text('Employee List',
                            style: TextStyle(
                                height: 10,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white)))),
                height: 190.0,
                width: MediaQuery.of(context).size.width - 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage(
                            'Assets/images/iStock_000012204568_Large.jpg'),
                        fit: BoxFit.fill)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: InkWell(
                    onTap: () {},
                    child: Center(
                        child: Text('Pay Check',
                            style: TextStyle(
                                height: 10,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white)))),
                height: 190.0,
                width: MediaQuery.of(context).size.width - 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage('Assets/images/paycheck.jpg'),
                        fit: BoxFit.fill)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: InkWell(
                    onTap: () {},
                    child: Center(
                        child: Text('Report a problem',
                            style: TextStyle(
                                height: 10,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white)))),
                height: 190.0,
                width: MediaQuery.of(context).size.width - 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage('Assets/images/phan-biet-problem-va-trouble.jpg'),
                        fit: BoxFit.fill)),
              ),
            ],
          )),
          RaisedButton(
            color: Colors.red,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Icon(
                    Ionicons.log_out_outline,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Text(
                    "                Log Out                  ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Fluttertoast.showToast(msg: "Logged Out");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LogIn()));
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
