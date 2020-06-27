import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'account_screen.dart';
import 'detailsPage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:provider/provider.dart';
import 'package:netbor2/models/user.dart';
import '../services/database.dart';

var long;
var position;
var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

class locationScreen extends StatefulWidget {
  @override
  _locationScreenState createState() => _locationScreenState();
}

class _locationScreenState extends State<locationScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Geolocator().getPositionStream(locationOptions),
      builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
      if (snapshot.hasError)
        return new Text('Error: ${snapshot.error}');
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return new Text('Loading...');
        default:
          return
            Container(
            child: Center(
                child:
                Text(snapshot.data.latitude.toString())

            ),
          );
      }
  });
}}
