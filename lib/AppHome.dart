import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vofz_app5/Start.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin= false;

  signOut()async{

    Navigator.push(context, MaterialPageRoute(builder: (context)=> Start()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: Container(
          child: !isloggedin? CircularProgressIndicator():
          Column(
            children: <Widget>[
              SizedBox(height: 40.0),
              Container(
                height: 300,
                child: Image.asset ('images/vofz_logo.jpeg', fit: BoxFit.contain,),
              ),
              Container(
                child: Text("Hello ${user.displayName} you are Logged in as ${user.email}",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              SizedBox(height: 100.0),
              RaisedButton(
                padding: EdgeInsets.fromLTRB(70,10,70,10),
                onPressed: signOut,
                child: Text('Signout',style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                )),
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              )
            ],
          ),
        )
    );
  }
}


