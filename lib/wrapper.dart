import 'package:flutter/material.dart';
import 'package:netbor2/screens/home.dart';
import 'package:netbor2/models/user.dart';
import 'package:provider/provider.dart';
import 'screens/authenticate.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final uid = Provider.of<User>(context);
 if (uid == null) {
   return Authenticate();
 }
 else {
   //return MyHomePage();
   return MyHomePage();
 }
  }
}