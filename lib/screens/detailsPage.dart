import 'package:flutter/cupertino.dart';
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
    return
     Scaffold(
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10 ),
                children: <Widget>[
                  Center(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage:
                        (widget.post.data['picURL'] != null) ? NetworkImage(widget.post.data['picURL']) : AssetImage('images/logohappy.png'),
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
                  color: null,
                  border: Border.all(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(widget.post.data['bio']),
                            ),),
                      )     ,

                    ],
                  ),

                ]),),);}}


