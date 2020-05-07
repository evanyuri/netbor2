import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './screens/login_screen.dart';
import 'screens/account_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import './screens/create_account.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyApp',
      theme: ThemeData(
// Define the default brightness and colors.
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.white,
        accentColor: Colors.white,

// Define the default font family.
        fontFamily: 'Varela Round',

// Define the default TextTheme. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: LoginScreen(),
      routes:<String, WidgetBuilder> {
        '/firstscreen': (BuildContext context) => new MyApp(),
        '/signup': (BuildContext context) => new CreateAccountScreen(),
        '/homescreen': (BuildContext context) => new Home(),
      },

    );
  }


}
