import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';
import '../employee/sidedrawer.dart';
import '../../../utils/firebaseApi/fireBaseApi.dart' as firebaseApi;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'managerHomeScreen.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime BeginweekDay =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday));
  DateTime EndweekDay =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 4));

  var selectedDate = '';
  var status = Map<String, Color>();
  var blocks = [
    ['Morning', 'Packging'],
    ['Evening', 'Packging'],
    ['Night', 'Packging'],
    ['Morning', 'Printing'],
    ['Evening', 'Printing'],
    ['Night', 'Printing'],
    ['Morning', 'Checking'],
    ['Evening', 'Checking'],
    ['Night', 'Checking'],
    ['Morning', 'Glueing'],
    ['Evening', 'Glueing'],
    ['Night', 'Glueing']
  ];
  var blockStatus = [];
  var blockEmployee = [];
  var flag = 0;

  SetStatus() {
    setState(() {
      status["Available"] = Color(0xFFE5D352);
      status["Approved"] = Color(0xFF8E9E1A);
      status["Pending"] = Color(0xFFAC3931);
    });
  }

  SetBlock() async {
    for (var block in blocks) {
      await firebaseApi.FireBaseApi.GetStatus(block[0], block[1])
          .then((value) async {
        blockStatus.add(value);
        await firebaseApi.FireBaseApi.GetBlockEmployee(block[0], block[1])
            .then((value) {
          blockEmployee.add(value);
        });
      });
    }
    SetStatus();
    setState(() {
      flag = 1;
    });
  }

  @override
  initState() {
    super.initState();
    SetBlock();
    setState(() {
      selectedDate = DateFormat('dd/MM').format(BeginweekDay) +
          ' - ' +
          DateFormat('dd/MM').format(EndweekDay);
    });
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
                  'Manager Schedule ',
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
      body: Container(
        child: flag != 1
            ? Container(
                child: Column(
                  children: [
                    Text(
                      "Loading..",
                      style: TextStyle(fontSize: 30),
                    ),
                    SpinKitDoubleBounce(
                      color: Colors.black,
                    ),
                  ],
                ),
              )
            : Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("Assets/wp7233443.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Center(
                        child: Text(
                      'Work Schedule for Week Date $selectedDate',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),
                    )),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black,
                                  ),
                              child: Center(
                                  child: Text(
                                'Shift',
                                style: TextStyle(color: Colors.white),
                              ))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50),

                              ),
                              child: Center(child: Text('Morning',style: TextStyle(color: Colors.white),))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(child: Text('Evening',style: TextStyle(color: Colors.white),))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    )
                                  ]
                              ),
                              child: Center(child: Text('Night',style: TextStyle(color: Colors.white),))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black
                              ),
                              child: Center(child: Text('Packging',style: TextStyle(color: Colors.white),))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[0]]),
                              child: Center(
                                child: Text(blockEmployee[0]),
                              )),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[1]]),
                              child: Center(child: Text(blockEmployee[1]))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[2]]),
                              child: Center(child: Text(blockEmployee[2]))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black
                              ),
                              child: Center(child: Text('Printing',style: TextStyle(color: Colors.white),))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[3]],
                                 ),
                              child: Center(child: Text(blockEmployee[3]))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[4]]),
                              child: Center(child: Text(blockEmployee[4]))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[5]]),
                              child: Center(child: Text(blockEmployee[5]))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black
                              ),
                              child: Center(child: Text('Checking',style: TextStyle(color: Colors.white),))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[6]]),
                              child: Center(child: Text(blockEmployee[6]))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[7]]),
                              child: Center(child: Text(blockEmployee[7]))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                                color: status[blockStatus[8]],
                              ),
                              child: Center(child: Text(blockEmployee[8]))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),

                              ),
                              child: Center(child: Text('Glueing',style: TextStyle(color: Colors.white),))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[9]]),
                              child: Center(child: Text(blockEmployee[9]))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[10]]),
                              child: Center(child: Text(blockEmployee[10]))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: status[blockStatus[11]]),
                              child: Center(child: Text(blockEmployee[11]))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(child: Text('Manager',style: TextStyle(color: Colors.white),))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(child: Text(''))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(child: Text(''))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(child: const Text(''))),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 20,),

                  ],
                ),
              ),
      ),
    );
  }
}
