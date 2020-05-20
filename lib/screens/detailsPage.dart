import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  DetailPage({this.post});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
// Define the default brightness and colors.
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.white,
          accentColor: Colors.white,

// Define the default font family.
 // Define the default TextTheme. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            ),
        ),
        home: Scaffold(
          body: SafeArea(
            child: ListView(
                children: <Widget>[
                  Center(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(widget.post.data['picURL']),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),

          child: Center(
                  child: Text(
                      widget.post.data['name']),
                  ),),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(

                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(widget.post.data['blurb']
                            ),),),),],),
                  Container(
                      padding: EdgeInsets.all(20),

                      child: Row( children: <Widget>[
                        Text(
                            'About:'
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
                  ),

                ]),),));}}


