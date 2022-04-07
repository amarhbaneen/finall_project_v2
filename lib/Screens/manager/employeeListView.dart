import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/employee/sidedrawer.dart';
import 'package:finall_project_v2/Screens/manager/registerEmployeeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection('users');

  Future<int> getCount() async {
    int count = await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) => value.size);
    return count;
  }
  var count ;
  @override
  void initState()
  {
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
                  'Employee List ',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                GestureDetector(
                  child: Icon( Ionicons.arrow_back, color: Colors.white  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => managerHomeScreen()));
                  } ,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').where("type",isEqualTo: 'employee')
        .where("manager",isEqualTo: widget.managerName)
            .snapshots(),
        builder: (context, snapshot) {
          return Column(children: [
            snapshot.hasData
                ? Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            child:ListTile(
                              leading: Icon(Ionicons.person, size: 40),
                                trailing:Container(
                                  height: 50.0,
                                  width: 40.0,
                                  child: FloatingActionButton(
                                    child: Icon(Icons.remove),
                                    backgroundColor: Colors.black26,
                                    foregroundColor: Colors.red,
                                    onPressed: () {
                                      String? uid = snapshot.data?.docs[index].id.toString();
                                      FirebaseFirestore.instance.collection('users').doc(uid).delete();


                                    },
                                  ),
                                ),
                                title: Text(
                                snapshot.data?.docs[index]['firstName'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(snapshot.data?.docs[index]['lastName'],
                                  style: TextStyle(fontWeight: FontWeight.bold)),
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
          onPressed: ()  {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => RegistrationScreen(widget.managerName)));

          },
          ),
            SizedBox(height: 20),


          ]);
        },
      ),

    );
  }



}
