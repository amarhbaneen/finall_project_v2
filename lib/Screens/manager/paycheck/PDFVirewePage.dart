
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../utils/demensions.dart';
import '../../../utils/firebaseApi/fireBaseApi.dart';
import '../../employee/sidedrawer.dart';
import 'package:intl/intl.dart';

import '../managerHomeScreen.dart';




class pdfViewer extends StatefulWidget {
  const pdfViewer({Key? key}) : super(key: key);


  @override
  State<pdfViewer> createState() => _pdfViewerState();
}

class _pdfViewerState extends State<pdfViewer> {
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('users');
  var pdfsFiles;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedDate =DateFormat('MMM/yyyy').format(DateTime.now());
   String id ='aa';
  String widgetName = 'manager';
  bool pickerIsExpanded = false;
  int _pickerYear = DateTime.now().year;
  DateTime _selectedMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );


  getData()
  async {
    final user =
        await _userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
    setState(() {
      id = user['id'];
    });
  }

  initState() {
      super.initState();
      getData();

    }



  List<Widget> generateRowOfMonths(from, to) {
    List<Widget> months = [];
    for (int i = from; i <= to; i++) {
      DateTime dateTime = DateTime(_pickerYear, i, 1);
      final backgroundColor = dateTime.isAtSameMomentAs(_selectedMonth)
          ? Colors.blueAccent
          : Colors.black;
      months.add(
        AnimatedSwitcher(
          duration: kThemeChangeDuration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(

              opacity: animation,
              child: child,
            );
          },
          child: TextButton(

            key: ValueKey(backgroundColor),
            onPressed: () {
              setState(() {
                _selectedMonth = dateTime;
                selectedDate = DateFormat('MM/yyyy').format(dateTime);
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: CircleBorder(),
            ),
            child: Text(

              DateFormat('MMM').format(dateTime),
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ),
      );
    }
    return months;
  }

  List<Widget> generateMonths() {
    return [
      Container(
        padding: MediaQuery.of(context).size.width > webScreenSize  ?  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/2.5):null,
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: generateRowOfMonths(1, 6),
        ),
      ),
      Container(
        padding: MediaQuery.of(context).size.width > webScreenSize  ?  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/2.5):null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: generateRowOfMonths(7, 12),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
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
                    child: Icon(Ionicons.menu_sharp),
                    elevation: 0,
                    color: Colors.transparent,
                  ),
                  Text(
                    'Pay Check ',
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
        body: Column(children:[
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _pickerYear = _pickerYear - 1;
                  });
                },
                icon: Icon(Icons.navigate_before_rounded),
              ),
              Expanded(

                child: Center(
                  child: Text(
                    _pickerYear.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _pickerYear = _pickerYear + 1;
                  });
                },
                icon: Icon(Icons.navigate_next_rounded),
              ),
            ],
          ),
          ...generateMonths(),
          Expanded(child: buildList()),
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
        ],
        ),
    );
  }

  Widget buildList()
  {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('paychecks')
          .where('owneruid',isEqualTo: id)
          .where('payCheckDate', isEqualTo: selectedDate.toString())
          .snapshots(),
      builder: (context, snapshot) {
        return Column(
            children: [
              Expanded(
                  child:
                  ListView.builder(
                    padding:MediaQuery.of(context).size.width > webScreenSize  ?  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/2.5): null,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: [
                        InkWell(
                            onTap: () {
                              MediaQuery.of(context).size.width > webScreenSize  ? FireBaseApi.downloadFileWeb(snapshot.data?.docs[index]['payCheckUrl'],snapshot.data?.docs[index]['owneruid']):
                              FireBaseApi.downloadFiletoDevice(snapshot.data?.docs[index]['payCheckUrl'],snapshot.data?.docs[index]['owneruid']);
                            },
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Icon(Ionicons.download),
                                title:  Text('$id'),
                                subtitle: Text('paycheck for month ${snapshot.data?.docs[index]['payCheckDate']}'),
                              )
                            )),
                      ]);
                    },
                    itemCount: snapshot.data!.docs.length,
                  )
              )

            ]);
      },
    );
  }




}

