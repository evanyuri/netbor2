import 'package:flutter/material.dart';
import './login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../usermanagement.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
String _email;
String _password;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          body: SafeArea(
              child: Center(
                child: ListView(
                    padding: EdgeInsets.only(top: 100.0),
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('images/logohappy.png', height: 90, width: 90),
                            Text(
                              'Welcome to the Netborhood',
                              style: TextStyle(
                                fontFamily: 'Varela Round',
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),]),
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
                          margin: EdgeInsets.only(top: 2.0),
                          child: ButtonTheme(
                              minWidth: 200,
                              child: RaisedButton(child: Text('Create Account'),
                                  onPressed: () {
                                FirebaseAuth.instance.createUserWithEmailAndPassword(
                                    email: _email,
                                    password: _password).then((signedInUser) {
                                      UserManagement().storeNewUser(signedInUser, context);

                                }
                                );
                                  }))),
                      Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: ButtonTheme(
                              minWidth: 200,
                              child: RaisedButton(
                                color: Colors.black,
                                child: Text('Return to Login'),
                                onPressed: () {
                                  // Navigate to the second screen using a named route.
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return LoginScreen();
                                      }));
                                },
                              ))),
                    ]),
              )),
        ));
  }
}
