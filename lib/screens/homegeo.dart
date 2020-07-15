import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'account_screen.dart';
import 'detailsPage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:provider/provider.dart';
import 'package:netbor2/models/user.dart';
import '../services/database.dart';
import 'donationPage.dart';
import 'cardhome.dart';

String _usersearch;
Geoflutterfire geo;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //Stream location
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 30);
    //navigate to details page function
    navigateToDetail(DocumentSnapshot post) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    post: post,
                  )));
    }

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          return StreamBuilder(
              stream: Geolocator().getPositionStream(locationOptions),
              builder:
                  (BuildContext context, AsyncSnapshot<Position> snapshot) {
                query() {
                  geo = Geoflutterfire();
                  GeoFirePoint myLocation = geo.point(
                      latitude: snapshot.data.latitude,
                      longitude: snapshot.data.longitude);
                  Firestore.instance
                      .collection("bios")
                      .document(user.uid)
                      .updateData({"position": myLocation.data});

                  //if search bar is empty return all by distance
                  if (_usersearch == "") {
                    geo = Geoflutterfire();
                    GeoFirePoint center = geo.point(
                        latitude: snapshot.data.latitude,
                        longitude: snapshot.data.longitude);
                    Firestore _firestore = Firestore.instance;

                    var collectionReference = _firestore.collection('bios');

                    var stream = geo
                        .collection(collectionRef: collectionReference)
                        .within(
                        center: center, radius: 10000, field: 'position');
                    return stream;
                  } else {
                    //if search bare contains anything return the search sorted by distance
                    geo = Geoflutterfire();
                    GeoFirePoint center = geo.point(
                        latitude: snapshot.data.latitude,
                        longitude: snapshot.data.longitude);
                    Firestore _firestore = Firestore.instance;
                    var collectionReference = _firestore
                        .collection('bios')
                        .where("hashes", arrayContains: _usersearch);

                    var stream = geo
                        .collection(collectionRef: collectionReference)
                        .within(
                        center: center, radius: 10000, field: 'position');

                    //stream upload user data

                    return stream;
                  }
                }

                return StreamBuilder(
                  stream: query(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                    return new Scaffold(
                        appBar: new AppBar(
                          backgroundColor: Colors.transparent,
                          leading: IconButton(
                              iconSize: 50,
                              color: Color(0xFF70e5c6),
                              icon: CircleAvatar(
                                radius: 28.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: (userData.picURL != null)
                                    ? NetworkImage(userData.picURL)
                                    : AssetImage('images/logohappy.png'),
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
                              onChanged: (search) =>
                                  setState(() => _usersearch = search),
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
                                    onPressed: () async {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return
                                                  donationPage();
                                                  //donationPage();
                                              }));
                                    },
                                    padding: EdgeInsets.only(top: 7.0),
                                    child: Icon(
                                      Icons.card_giftcard,
                                      color: Colors.teal,
                                      size: 35,
                                    )))
                          ],
                        ),
                        body: ListView(
                          children:
                          snapshot.data.map((DocumentSnapshot data) {
                            return GestureDetector(
                              onTap: () => navigateToDetail(data),
                              child: Card(
                                color: Colors.black,
                                child: new ListTile(
                                  leading: CircleAvatar(
                                      radius: 28.0,
                                      backgroundColor: Colors.blueGrey,
                                      backgroundImage:
                                      (data['picURL'] != "")
                                          ? NetworkImage(data['picURL'])
                                          : AssetImage(
                                          'images/logohappy.png')),
                                  title: new Text(data['name']),
                                  subtitle: new Text(data['blurb']),
                                ),
                              ),
                            );
                          }).toList(),
                        ));
                  }
                  ,
                );
              });
        });
  }
}
