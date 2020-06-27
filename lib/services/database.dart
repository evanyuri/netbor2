import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netbor2/models/user.dart';
import '../models/bio.dart';
import '../models/user.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';


class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference bioCollection = Firestore.instance.collection(
      'bios');

  Future updateUserData(String name, String bio, String blurb,
      String picURL,) async {
    return await bioCollection.document(uid).setData({''
        'name': name,
      'bio': bio,
      'blurb': blurb,
      'picURL': picURL,

    });
  }

// bios list from snapshot
  List<Bio> _bioListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Bio(
        name: doc.data['name'] ?? '',
        bio: doc.data['bio'] ?? '',
        blurb: doc.data['blurb'] ?? '',
        picURL: doc.data['picURL'] ?? '',
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      bio: snapshot.data['bio'],
      blurb: snapshot.data['blurb'],
      picURL: snapshot.data['picURL'],
    );
  }

  // get bios stream
  Stream<List<Bio>> get bios {
    return bioCollection.snapshots()
        .map(_bioListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return bioCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}