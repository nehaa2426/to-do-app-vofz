import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vofz_app5/Login.dart';
// import 'file:///C:/Users/Neha/AndroidStudioProjects/vofz_app5/lib/Authroization/Login.dart';


class HomePage3 extends StatefulWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
              children: <Widget>[
                SizedBox(height: 160),
                Container(
                  child: Image.asset(
                    'images/vofz_logo.jpeg', fit: BoxFit.contain,),
                ),
                SizedBox(height: 20),
                Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "Hello Neha Aitharaju you are logged in as neha.aitharaju4@gmail.com",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )
                ),
                SizedBox(height: 20),
                RaisedButton(
                    padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                    },
                    child: Text('SIGN OUT', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                ),
              ]
          )
      ),
    );
  }
}

