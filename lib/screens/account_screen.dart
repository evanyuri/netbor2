import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netbor2/models/user.dart';
import 'package:netbor2/services/auth.dart';
import '../services/database.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geohash/geohash.dart';



class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _currentName;
  String _currentBio;
  String _currentBlurb;
  String _currentPicURL;
  String _currentHash;
  double _currentLat;
  double _currentLong;
  File _image;


  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    var geolocator = Geolocator();

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }


    final user = Provider.of<User>(context);

    // TODO: implement build
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {

          UserData userData = snapshot.data;

          return Scaffold(
            body: SafeArea(
              child:ListView(
                  children: <Widget>[
                    Center(child: Builder(
                        builder: (context) {
                          if (userData.picURL==null) {
                            return CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                (_image != null) ? FileImage(_image) :
                                AssetImage('images/logohappy.png'),
                                backgroundColor: Colors.black,
                                child: Stack(children: <Widget>[Align(
                                    alignment: Alignment.bottomLeft,
                                    child: FloatingActionButton(
                                      onPressed: getImage,
                                      child: Icon(Icons.add),
                                    )),
                                ],

                                ));}
                          else {return CircleAvatar(
                              radius: 100,
                              backgroundImage:
                              (_image != null) ? FileImage(_image) :
                              NetworkImage(userData.picURL),
                              backgroundColor: Colors.black,
                              child: Stack(children: <Widget>[Align(
                                  alignment: Alignment.bottomLeft,
                                  child: FloatingActionButton(
                                    onPressed: getImage,
                                    child: Icon(Icons.add),
                                  )),
                              ],

                              ));}
                        })),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Row( children: <Widget>[
                          Text(
                              'Name:'
                          )
                        ],
                        )),
                    TextFormField(
                      initialValue: userData.name,
                      onChanged: (name) => setState(() => _currentName = name),
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
                              'Blurb:'
                          )
                        ],
                        )),
                    TextFormField(
                      initialValue: userData.blurb,
                      onChanged: (blurb) => setState(() => _currentBlurb = blurb),
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
                          child: TextFormField(
                            initialValue: userData.bio,
                            onChanged: (bio) => setState(() => _currentBio = bio),
                            maxLines: null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:  BorderRadius.all(
                                  const Radius.circular(12.0),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: ButtonTheme(
                            minWidth: 200,
                            child: RaisedButton(
                              color: Colors.teal,
                              child: Text('Save'),
                              onPressed: () async {
                                if (_image!=null){
                                  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref()
                                      .child(userData.uid);
                                  final uploadTask = firebaseStorageRef.putFile(_image);
                                  final StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
                                  final ref = FirebaseStorage.instance.ref().child(userData.uid);
                                  // no need of the file extension, the name will do fine.
                                  _currentPicURL = await ref.getDownloadURL();
                                }
                                Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                                var long = _currentLong = position.longitude.toDouble();
                                var lat = _currentLat = position.latitude.toDouble();
                                var encoded = Geohash.encode(lat,long);
                                print (encoded);
                                print (_currentLat);
                                print (position);
                                _currentHash = encoded;




                                await DatabaseService(uid: user.uid).updateUserData(
                                    _currentName ?? userData.name,
                                    _currentBio ?? userData.bio,
                                    _currentBlurb ?? userData.blurb,
                                    _currentPicURL ?? userData.picURL);
                                Navigator.pop(context);



                              },
                            ))),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: ButtonTheme(
                          minWidth: 200,
                          child: FlatButton(
                              color: Colors.transparent,
                              child: Text('Logout'),
                              onPressed: () async {
                                await _auth.signOut();
                                Navigator.pop(context);
                              }
                          )),),
                    Container(
                      margin: EdgeInsets.only(top: 50.0),
                      child: ButtonTheme(
                          minWidth: 200,
                          child: FlatButton(
                            color: Colors.transparent,
                            child: Text(
                                'Delete Account',
                                style: TextStyle(color: Colors.red)),
                            onPressed: () async {
                              FirebaseUser user = await FirebaseAuth.instance.currentUser();
                              user.delete();
                              Navigator.pop(context);
                            },
                            //async {
                            // await AuthService().deleteUser(email, password);
                            //}

                          )),),


                  ]

              ),
            ),);
        }


    );
  }
}



