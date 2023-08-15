//actual login page and it check to see if person enters it with an error of some sort
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'file:///C:/Users/Neha/AndroidStudioProjects/vofz_app5/lib/MainApp/Tabs.dart';
import 'Start.dart';
import 'Tabs.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password, _name;

  // checkAuthentification()async{
  //   _auth.authStateChanges().listen((user){
  //     if(user != null){
  //       Navigator.push(context, MaterialPageRoute(builder: (context)=> Tabs()));
  //     }
  //   });
  // }
  // void initState(){
  //   super.initState();
  //   this.checkAuthentification();
  // }

  login()async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Tabs()));

      try{
        UserCredential user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
        if(user!= null){
          await FirebaseAuth.instance.currentUser.updateProfile(displayName:_name);
        }
      }
      catch(e){
        showError(e.errormessage);
      }
    }
  }
  showError(String errormessage){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),

            actions: <Widget>[
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('OK')
              ),
            ],
          );
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget> [
                SizedBox(height: 150),
                Container(
                  child: Image.asset ('images/vofz_logo.jpeg', fit: BoxFit.contain,),
                ),
                Container(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20,),
                            Container(
                                padding: EdgeInsets.fromLTRB(20,0,20,0),
                                child: TextFormField(

                                  // ignore: missing_return
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Enter Correct Email Format';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        prefixIcon: Icon(Icons.email)
                                    ),
                                    onSaved: (input) => _email = input
                                )
                            ),
                            SizedBox(height: 20,),
                            Container(
                                padding: EdgeInsets.fromLTRB(20,0,20,0),
                                child: TextFormField(
                                  // ignore: missing_return
                                    validator: (input) {
                                      if (input.length < 6)
                                        return 'Please Provide a Minimum of 6 characters';
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: Icon(Icons.lock)
                                    ),
                                    obscureText: true,
                                    onSaved: (input) => _password = input
                                )
                            ),
                            SizedBox(height: 30),
                            RaisedButton(
                                padding: EdgeInsets.fromLTRB(20,0,20,0),
                                onPressed: login,
                                child: Text('LOGIN', style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
                                color: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )
                            )
                          ],
                        )
                    )
                )
              ],
            )
        )
    );
  }
}