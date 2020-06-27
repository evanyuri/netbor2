import 'package:geolocator/geolocator.dart';

class User {

  final String uid;

  User({ this.uid});

}
class UserData {

  final String uid;
  final String name;
  final String blurb;
  final String bio;
  final String picURL;

  UserData({this.uid, this.name, this.blurb, this.bio, this.picURL});

}