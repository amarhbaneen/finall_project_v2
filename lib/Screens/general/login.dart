import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/employee/employeeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('users');
  String _userType = 'a';
  bool _isloading = false;
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool rememberpwd = false;
  bool sec = true;
  var visable = Icon(
    Icons.visibility,
    color: Color(0xff4c5166),
  );
  var visableoff = Icon(
    Icons.visibility_off,
    color: Color(0xff4c5166),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: SingleChildScrollView(
                    child: Column(

                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          "Welcome Back! 🎈",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        buildEmail(),
                        SizedBox(
                          height: 50,
                        ),

                        buildPassword(),
                        SizedBox(
                          height: 50,
                        ),
                        if(_isloading)
                          CircularProgressIndicator(),
                        if(!_isloading)
                          buildLoginButton(),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            buildGoogle(),
                            buildFacebook(),

                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffebefff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                )
              ]),
          child: TextFormField(
            controller: emailController,
            onSaved: (value) {
              emailController.text = value!;
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff4c5166),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffebefff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                )
              ]),
          child: TextFormField(
            controller: passwordController,
            onSaved: (value) {
              passwordController.text = value!;
            },
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.password,
                  color: Color(0xff4c5166),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }


  Widget buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Container(
        width: double.infinity,
        child: RaisedButton(
          onPressed: () {
            login(emailController.text, passwordController.text);
          },
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.black,
          padding: EdgeInsets.all(30),
          child: Text(
            "Login",
            style: TextStyle(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }


  Widget buildGoogle() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: new Image.asset("Assets/images/google.png"),
    );
  }

  Widget buildFacebook() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: new Image.asset("Assets/images/facebook.png"),
    );
  }

  void login(String email, String password) async
  {
    setState(() {
      _isloading = true;
    });

      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((uid) async =>
      {
        _userType = (await _userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get())['type'],
        if (_userType == 'employee')
        {
          Fluttertoast.showToast(msg: "LogIn Successes"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => employee()))
        }
        else
          {
            throw const FormatException('User type isnt allowed')
          }
      }).catchError((e) {
        Fluttertoast.showToast(msg: e.message);
        setState(() {
          _isloading = false;
        });
      });
    }
  }


