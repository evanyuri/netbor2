import 'package:firebase_auth/firebase_auth.dart';
import 'package:netbor2/services/database.dart';
import 'package:netbor2/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

// create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

// auth change user stream

  Stream <User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  //sign-in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the ui.d
      await DatabaseService(uid: user.uid).updateUserData(
          'New User', 'My bio is blank :-O', 'my blurb', 'https://firebasestorage.googleapis.com/v0/b/netbor2.appspot.com/o/logohappy.png?alt=media&token=ec740992-2c8c-4456-a507-1b735eb5e6b3',);

      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign-out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// delete-account


}
