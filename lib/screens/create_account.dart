import 'package:flutter/material.dart';
import 'package:netbor2/services/auth.dart';
import './login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';



class CreateAccountScreen extends StatefulWidget {
  final Function toggleView;
  CreateAccountScreen({this.toggleView});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
String email = '';
String password = '';
String passwordConfirm ='';
String error = '';
final AuthService _auth = AuthService();
final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          body: SafeArea(
              child: Center(
                child: ListView(
                    padding: EdgeInsets.only(top: 50.0),
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
                            hintText: '',
                            labelText: 'email:',
                          )),
                              TextFormField(
                                  obscureText: true,
                                  validator: (val) => val.length < 6  ? 'Enter a password 6+ chars long' : null,
                                  onChanged: (val) {setState(() => password = val);},
                                  style: TextStyle(
                                    decorationColor: Colors.white,
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: '',
                                    labelText: 'new password:',
                                  )),
                              TextFormField(
                                  obscureText: true,
                                  validator: (val) => val.length < 6  ? 'Enter a password 6+ chars long' : null,
                                  onChanged: (val) {setState(() => passwordConfirm = val);},
                                  style: TextStyle(
                                    decorationColor: Colors.white,
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: '',
                                    labelText: 'confirm password:',
                                  )),

                Container(
                    margin: EdgeInsets.only(top: 2.0),
                    child: ButtonTheme(
                        minWidth: 200,
                        child: RaisedButton(child: Text('Create Account'),
                            onPressed: () async {
                          if (password == passwordConfirm) {
                            if (_formkey.currentState.validate()) {
                                dynamic result = await _auth
                                    .registerWithEmailAndPassword(
                                    email, password);
                                if (result == null) {
                                  setState(() =>
                                  error = 'please provide a valid email');
                                }}}
                        else {setState(() =>
                          error = 'passwords do not match');}}))),
                Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: ButtonTheme(
                        minWidth: 200,
                        child: FlatButton(
                          color: Colors.transparent,
                          child: Text('Return to Login'),
                          onPressed: () {widget.toggleView();},
                        ))),]),
                            )]),),
                          )



                    ),
              );

  }
}
