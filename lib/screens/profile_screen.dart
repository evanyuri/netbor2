import 'package:flutter/material.dart';

class profile_screen extends StatefulWidget {
  @override
  _profile_screenState createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
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
          child: ListView(
            children: <Widget>[
          Center(
          child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('images/bust.png'),
        )
                       ),
              Text(
                'My Name'
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
                        child: Container(

                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text( 'Hello this part of the profile is about myself. I am a chemical engineer who has a passsion for helping the world. I dont do things for money. I do things becasue I think they will help me or my loved ones.',
                        ),),),
                      )     ,

                  ],
              )
  ]),
      ),));
  }
}


