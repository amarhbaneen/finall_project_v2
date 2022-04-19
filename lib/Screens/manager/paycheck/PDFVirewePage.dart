
import 'package:finall_project_v2/Screens/manager/managerHomeScreen.dart';
import 'package:finall_project_v2/utils/firebaseApi/firebaseFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../utils/demensions.dart';
import '../../../utils/firebaseApi/fireBaseApi.dart';
import '../../employee/sidedrawer.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';



class pdfViewer extends StatefulWidget {
  const pdfViewer({Key? key}) : super(key: key);

  @override
  State<pdfViewer> createState() => _pdfViewerState();
}

class _pdfViewerState extends State<pdfViewer> {
  late Future<List<FirebaseFile>>  pdfsFiles;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedDate =DateFormat('MMM/yyyy').format(DateTime.now());
  String widgetName = 'manager';
  bool pickerIsExpanded = false;
  int _pickerYear = DateTime.now().year;
  DateTime _selectedMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );

  dynamic _pickerOpen = true;


  initState()  {
      super.initState();
       pdfsFiles = FireBaseApi.listAll('pdfs/');


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
                selectedDate = DateFormat('MMM/yyyy').format(dateTime);
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
      body:

          Column(children: [
          Material(
            color: Theme.of(context).cardColor,
            child: AnimatedSize(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
              child: Container(
                height: _pickerOpen ? null : 0.0,
                child: Column(
                  children: [
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
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),

          Expanded(child: listBuild()),

          Center(child: Material(
            elevation: 8,
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
            SizedBox(
              height: 20.0,
            ),
          ],
          ),
    );
  }
  Widget listBuild() => FutureBuilder<List<FirebaseFile>>(
        future: pdfsFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                final files = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final file = files[index];

                          return buildFile(context, file);
                        },
                      ),
                    ),
                  ],
                );
              }
          }
        },
  );

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
    leading: Icon(
      Icons.download
    ),
    title: Text(
      file.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.blue,
      ),
    ),
    onTap: ()async {
      var f ;
      MediaQuery.of(context).size.width > webScreenSize ?
      await FireBaseApi.downloadFileWeb(file.ref):  FireBaseApi.downloafFile(file.ref);

      final snackBar = SnackBar(
        content: Text('Downloaded ${file.name}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
  );



}
