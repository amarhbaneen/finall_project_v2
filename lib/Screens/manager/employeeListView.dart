import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/employee/sidedrawer.dart';
import 'package:finall_project_v2/Screens/manager/registerEmployeeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/demensions.dart';
import 'managerHomeScreen.dart';

class employeeListView extends StatefulWidget {
  final String managerName;

  const employeeListView(this.managerName);

  @override
  State<employeeListView> createState() => _employeeListViewState();
}

class _employeeListViewState extends State<employeeListView> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<int> getCount() async {
    int count = await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) => value.size);
    return count;
  }

  var count;

  @override
  void initState() {
    count = getCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideDrawer('manager'),
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
                  'Employees List ',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where("type", isEqualTo: 'employee')
            .where("manager", isEqualTo: widget.managerName)
            .snapshots(),
        builder: (context, snapshot) {
          return Column(
              children: [
            snapshot.hasData
                ? Expanded(

                    child: ListView.builder(
                      padding:MediaQuery.of(context).size.width > webScreenSize  ?  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/2.5): null,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: [
                        InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                      (snapshot.data?.docs[index]['firstName'][0]).toUpperCase()
                                  ),
                                  backgroundColor: Colors.black,
                                  radius: 24,
                                ),
                                trailing: MaterialButton(
                                        onPressed: () {
                                          String? uid = snapshot.data?.docs[index].id.toString();
                                          FirebaseFirestore.instance.collection('users').doc(uid).delete();
                                        },
                                        child: Text(
                                          "remove",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                color: Colors.black),
                                title: Text(
                                  snapshot.data?.docs[index]['firstName'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    snapshot.data?.docs[index]['lastName'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            )),
                      ]);
                    },
                    itemCount: snapshot.data!.docs.length,
                  ))
                : Center(
                    child: CupertinoActivityIndicator(),
                  ),
            FloatingActionButton(

              child: Icon(Icons.add),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        RegistrationScreen(widget.managerName)));
              },
            ),
            SizedBox(height: 20),
            Center(child: Material(

              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
              child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => managerHomeScreen()));
                  },
                  child: Icon(
                    Ionicons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  )),
            )),
            SizedBox(height: 20)
          ]);
        },
      ),
    );
  }
}
