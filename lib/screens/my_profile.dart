import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netbor2/models/user.dart';
import 'package:netbor2/services/database.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';




class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Column(
        children: <Widget>[
          FutureBuilder(
    future: Provider.of(context).auth.getCurrentUID(),
     builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done){
      return Text("Done");}
      else {
        return CircularProgressIndicator();
    }

     }
    )],
    );
  }}


