import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netbor2/usermanagement.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _displayName;
  String _bio;
  UserManagement userManagement = new UserManagement();

   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
// Define the default brightness and colors.
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.white,
          accentColor: Colors.white,

// Define the default font family.
          fontFamily: 'Varela Round',

// Define the default TextTheme. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home: Scaffold(
          body: SafeArea(
            child:ListView(
                children: <Widget>[
                  Center(

                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('images/bust.png'),
                      backgroundColor: Colors.black,
                      child: Stack( children: <Widget>[Align(
                        alignment: Alignment.bottomLeft,
                        child: FloatingActionButton(
                          onPressed: (null),
                            child: Icon(Icons.add),
                        )),],

                      ))
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: Row( children: <Widget>[
                        Text(
                            'Name:'
                        )
                      ],
                      )),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _displayName = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0),
                        borderRadius:  BorderRadius.all(
                          const Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: Row( children: <Widget>[
                        Text(
                            'My Biography:'
                        )
                      ],
                      )),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:  BorderRadius.all(
                                const Radius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                      )     ,

                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: ButtonTheme(
                          minWidth: 200,
                          child: RaisedButton(
                            color: Color(0xFF70e5c6),
                            child: Text('Save'),
                            onPressed: () {

     },
                          ))),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: ButtonTheme(
                        minWidth: 200,
                        child: RaisedButton(
                          color: Colors.black,
                          child: Text('Logout'),
                          onPressed: () {FirebaseAuth.instance.signOut().then((value) {
                            Navigator
                            .of(context)
                                .pushReplacementNamed('/firstscreen');
                          })
                          .catchError((e) {
                            print(e);
                          });},

                          )),),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: ButtonTheme(
                  minWidth: 200,
                  child: RaisedButton(
                    color: Colors.black,
                    child: Text('Delete Account'),
                    onPressed: () {
                      // Navigate to the second screen using a named route.
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return (null);
                          }));
                    },)),),


                ]

            ),
          ),));
  }
}



