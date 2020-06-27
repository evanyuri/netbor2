import 'package:flutter/material.dart';
import 'package:netbor2/services/auth.dart';
import './create_account.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  String error = '';
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(

        child: ListView(
          padding: EdgeInsets.only(top: 10.0),
                        children: <Widget>[
                                   Image.asset('images/Logo.png', height: 90, width: 90),
              Center(
                          child: Text(
                'Welcome netbor',
                style: TextStyle(
                  fontFamily: '',
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
              Form(
                  key:_formkey,

                  child: Column(
                    children: <Widget>[
                      Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {setState(() => email = val);},
                        style: TextStyle(
                          decorationColor: Colors.white,
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'email',
                          labelText: null,
                        )),
                      Form(
                          child: TextFormField(
                              obscureText: true,
                              validator: (val) => val.length < 6  ? 'Enter a password 6+ chars long' : null,
                              onChanged: (val) {setState(() => password = val);},
                              style: TextStyle(
                                decorationColor: Colors.white,
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'password',
                                labelText: null,
                              ))),

                    ],
                  )
              ),

              Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        color: Colors.teal,
                        child: Text('Login'),
                        onPressed: () async{
                          if (_formkey.currentState.validate()) {
                            dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                         if (result == null) {
                           setState(() =>
                            error = 'Please provide vaild login credentials');
                          }
                          }
                          },
                      ))),
              Container(
                  margin: EdgeInsets.only(top: 2.0),
                  child: ButtonTheme(
                      minWidth: 200,
                      child: FlatButton(
                        color: Colors.transparent,
                          child: Text('Join the Netborhood'),
                    onPressed: () {widget.toggleView();},)),),
            ]),
      ))
    ;
  }
}
