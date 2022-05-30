import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';
import '../employee/sidedrawer.dart';
import '../../../utils/firebaseApi/fireBaseApi.dart' as firebaseApi;

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);


  @override
  State<Schedule> createState() => _ScheduleState();
}
class _ScheduleState extends State<Schedule> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedDate =DateFormat('DDDDD/MMM/yyyy').format(DateTime.now());
  var status = Map<String, Color>();
  var blocks = [['Morning','Packging'],['Evening','Packging'],['Night','Packging'],
  ['Morning','Printing'],['Evening','Printing'],['Night','Printing'],
  ['Morning','Checking'],['Evening','Checking'],['Night','Checking'],
  ['Morning','Glueing'],['Evening','Glueing'],['Night','Glueing']
  ];
  var blockStatus =[];
  var blockEmployee = [];
  var flag = 0;
  SetStatus()
  {
    setState(() {
      status["Available"] = Colors.blue;
      status["Approved"] = Colors.green;
      status["Pending"] = Colors.yellow;
    });
  }
  SetBlock()
  async {

    for(var block in blocks)
      {
        await firebaseApi.FireBaseApi.GetStatus(block[0], block[1]).then((value)
        async {
          blockStatus.add(value);
          await firebaseApi.FireBaseApi.GetBlockEmployee(block[0], block[1]).then((value)
          {
            blockEmployee.add(value);

          });
          setState(() {
            flag = 1;
          });
          });

        }
      SetStatus();

  }

  @override
 initState()  {
    super.initState();
    SetBlock();

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
        child: flag !=1 ? Center(child: Text('Loading')) :
        ListView(
        children: [
          Row(
                children: [
                  Center(child: Text('Work Schedule for Week Date $selectedDate'))
                ],
              ),
          Row(
            children: [
              Container(
                width:MediaQuery.of(context).size.width/4,
                height: MediaQuery.of(context).size.height/15,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
                ),
                  child: Center(child: Text('Shift'))),
              Container(
                  height: MediaQuery.of(context).size.height/15,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('Morning'))),
              Container(
                  height: MediaQuery.of(context).size.height/15,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('Evening'))),
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/15,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('Night'))),

            ],
          ),
          Row(
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('Packging'))),
              Container(
                  height: MediaQuery.of(context).size.height/9,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    color: status[blockStatus[0]]
                  ),

                  child: Center(child: Text(blockEmployee[0]),

                  )),
              Container(
                  height: MediaQuery.of(context).size.height/9,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[1]]
                  ),
                  child: Center(child: Text(blockEmployee[1]))),
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[2]]

                  ),
                  child: Center(child: Text(blockEmployee[2]))),

            ],
          ),
          Row(
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('Printing'))),
              Container(
                  height: MediaQuery.of(context).size.height/9,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[3]]

                  ),
                  child: Center(child: Text(blockEmployee[3]))),
              Container(
                  height: MediaQuery.of(context).size.height/9,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[4]]

                  ),
                  child: Center(child: Text(blockEmployee[4]))),
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[5]]

                  ),
                  child: Center(child: Text(blockEmployee[5]))),
            ],
          ),
          Row(
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('Checking'))),
              Container(
                  height: MediaQuery.of(context).size.height/9,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[6]]

                  ),
                  child: Center(child: Text(blockEmployee[6]))),
              Container(
                  height: MediaQuery.of(context).size.height/9,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[7]]

                  ),
                  child: Center(child: Text(blockEmployee[7]))),
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[8]]

                  ),
                  child: Center(child: Text(blockEmployee[8]))),

            ],
          ),
          Row(
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('Glueing'))),
              Container(
                  height: MediaQuery.of(context).size.height/9,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[9]]

                  ),
                  child: Center(child: Text(blockEmployee[9]))),
              Container(
                  height: MediaQuery.of(context).size.height/9,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[10]]

                  ),
                  child: Center(child: Text(blockEmployee[10]))),
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                      ,color: status[blockStatus[11]]

                  ),
                  child: Center(child: Text(blockEmployee[11]))),

            ],
          ),
          Row(
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('Manager'))),
              Container(
                  height: MediaQuery.of(context).size.height/9,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text(''))),
              Container(
                  height: MediaQuery.of(context).size.height/9,
                  width:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text(''))),
              Container(
                  width:MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: const Text(''))),

            ],
          ),
        ],
        ),
      ),
    );
  }
}
