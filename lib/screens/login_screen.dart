import 'package:flutter/material.dart';
import 'package:netbor2/services/auth.dart';
import './create_account.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      body: SafeArea(

        child: ListView(
          padding: EdgeInsets.only(top: 100.0),
                        children: <Widget>[
                                   Image.asset('images/Logo.png', height: 90, width: 90),
              Center(
                          child: Text(
                'Welcome Netbor',
                style: TextStyle(
                  fontFamily: 'Varela Round',
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
              Form(
                  child: TextFormField(
                      onChanged: (value) {setState(() {_email = value;});},
                      style: TextStyle(
                        decorationColor: Colors.white,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: '',
                        labelText: 'email:',
                      ))),
              Form(
                  child: TextFormField(
                      onChanged: (value) {setState(() {_password = value;});},
                      style: TextStyle(
                        decorationColor: Colors.white,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: '',
                        labelText: 'password:',
                      ))),
              Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        color: Colors.teal,
                        child: Text('Login'),
                        onPressed: () {
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _email,
                                password: _password)
                          .then((AuthResult auth) {
                            Navigator.of(context).pushReplacementNamed('/homescreen');})
                          .catchError((e) {
                            print(e);
                          });
                        },
                      ))),
              Container(
                  margin: EdgeInsets.only(top: 2.0),
                  child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        color: Colors.black,
                          child: Text('Join the Netborhood'),
                    onPressed: () {
                      // Navigate to the second screen using a named route.
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return CreateAccountScreen();
                          }));
                    },)),),
          Container(
          margin: EdgeInsets.only(top: 2.0),
          child: ButtonTheme(
              minWidth: 200,
              child: RaisedButton(
                color: Colors.black,
                child: Text('Sign-In Anon'),
                onPressed: () async{
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {print('error signing in');}
                  else {
                    print('signed in');
                    print(result.uid);
                  }
                },)),)
            ]),
      )),
    );
  }
}
