//login/register.sign in with Google
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Login.dart';
import 'SignUp.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  navigateToLogin()async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
  }
  navigateToRegister()async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                children: <Widget> [
                  SizedBox(height: 160.0),
                  Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                          children: <Widget> [
                            Image.asset ('images/vofz_logo.jpeg', fit: BoxFit.contain,),
                          ]
                      )
                  ),
                  SizedBox(height: 30.0),
                  RichText(
                    text: TextSpan(
                        text: 'Welcome to ', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Voices of Gen-Z', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.teal)
                          )
                        ]
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('"Conversation that Matters"', style: TextStyle(fontSize: 20.0, color: Colors.black),),
                  SizedBox(height: 40.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          onPressed: navigateToLogin,
                          child: Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                            color: Colors.white,),),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.teal,
                        ),
                        SizedBox(width: 20.0),
                        RaisedButton(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          onPressed: navigateToRegister,
                          child: Text('REGISTER', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                            color: Colors.white,),),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.teal,
                        ),
                      ]
                  ),
                ]
            )
        )
    );
  }
}



