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



Geoflutterfire geo;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;

          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.transparent,
              leading:
              IconButton(
                  iconSize: 50,
                  color: Color(0xFF70e5c6),
                  icon: CircleAvatar(
                    radius: 28.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: (userData.picURL != null) ? NetworkImage(
                        userData.picURL) : AssetImage('images/logohappy.png'),
                  ),
                  onPressed: () {
                    // Navigate to the second screen using a named route.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return AccountScreen();
                        }));
                  }),
              title: Container(
                padding: EdgeInsets.only(top: 7),
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 7),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                Container(
                    height: 20,
                    width: 50,
                    child: FlatButton(

                        onPressed: (null),
                        padding: EdgeInsets.only(top: 7.0),
                        child: Image.asset('images/connects.png')))
              ],
            ),
            body: ListPage(),
          );}

    );
  }
}

class ListPage extends StatefulWidget {
  @override

  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {



  @override

  Widget build(BuildContext context) {
    //Stream location
    var long;
    var position;
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

//navigate to details page function
    navigateToDetail(DocumentSnapshot post){
      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: post,)));
    }

//Render App
    return StreamBuilder(
      stream: Geolocator().getPositionStream(locationOptions),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {

    if (snapshot.hasError)
    return new Text('Error: ${snapshot.error}');
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return new Text('Loading...');
      default:

      // get user profiles within your location
        geo = Geoflutterfire();
        GeoFirePoint center = geo.point(latitude: snapshot.data.latitude, longitude: snapshot.data.longitude);
        Firestore _firestore = Firestore.instance;
        var collectionReference = _firestore.collection('bios');

        var stream = geo
            .collection(collectionRef: collectionReference)
            .within(center: center, radius: 5000, field: 'position');


        return StreamBuilder(
          stream: stream,
          builder: (BuildContext context,
              AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children: snapshot.data.map((DocumentSnapshot data) {
                    return GestureDetector(
                      onTap: () => navigateToDetail(data),
                      child: Card(
                        color: Colors.black,
                        child: new ListTile(
                          leading: CircleAvatar(
                              radius: 28.0,
                              backgroundColor: Colors.blueGrey,
                              backgroundImage:
                              (data['picURL'] != null) ? NetworkImage(
                                  data['picURL']) : AssetImage(
                                  'images/logohappy.png')
                          ),
                          title: new Text(data['name']),
                          subtitle: new Text(data['blurb']),
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        );
    } });
  }
}


