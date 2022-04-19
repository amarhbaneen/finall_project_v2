import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finall_project_v2/Screens/manager/employeeListView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import '../../models/employeeModel.dart';
import '../../utils/demensions.dart';
import '../employee/sidedrawer.dart';

class RegistrationScreen extends StatefulWidget {
  final String managerName;

  RegistrationScreen(this.managerName);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;

  var CreatedUser;


  // string for displaying the error Message
  late String errorMessage;


  // editing Controller
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("last Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(100),
      color: Colors.black,
      child: MaterialButton(
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: Text(
            "SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

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
                  'Register A New Employee',
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
      body: Center(
        child: ListView(
          padding: MediaQuery.of(context).size.width > webScreenSize  ?  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/2.5): null,
          children: [
            SizedBox(height: 32),
            Icon(
              Ionicons.person_add,
              size: 35,
            ),
            Text(
              'Fill the next fields to register new employee under your managment',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 10),
            Center(child: firstNameField),
            SizedBox(height: 10),
            Center(child: secondNameField),
            SizedBox(height: 10),
            Center(child: emailField),
            SizedBox(height: 10),
            Center(child: passwordField),
            SizedBox(height: 10),
            Center(child: confirmPasswordField),
            SizedBox(height: 45),
            Center(child: signUpButton),
            SizedBox(height: 100),
            Center(
                child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
              child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            employeeListView(widget.managerName)));
                  },
                  child: Icon(
                    Ionicons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  )),
            )),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    register(email, password);
  }

  postDetailsToFirestore(createdUser) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    employeeModel userModel = employeeModel(
        uid: createdUser,
        email: emailEditingController.text,
        firstName: firstNameEditingController.text,
        lastName: secondNameEditingController.text,
        type: 'employee',
        manager: widget.managerName);

    // writing all the values

    await firebaseFirestore
        .collection("users")
        .doc(userModel.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => employeeListView(widget.managerName)));
  }

  Future<void> register(String email, String password) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);

    var auth = FirebaseAuth.instanceFor(app: app);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                CreatedUser = auth.currentUser?.uid,
                postDetailsToFirestore(CreatedUser)
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);

      await app.delete();
    }
  }
}
