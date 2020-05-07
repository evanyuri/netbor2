import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'account_screen.dart';

class Home extends StatefulWidget { //a statefulwidget (typed stfl)  makes the app interactive instead of passive)
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int count = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading:
          IconButton(
            iconSize: 50,
            color: Color(0xFF70e5c6),
        icon: Icon(Icons.account_circle),
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
    borderRadius:  BorderRadius.all(
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

                    onPressed: null,
                    padding: EdgeInsets.only(top:7.0),
                    child: Image.asset('images/connects.png')))
          ],
        ),
            body: Container(
            padding: EdgeInsets.all(3.0),
            child: GridView.builder(
              itemCount: count,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                return Container(child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: FlatButton(

                        onPressed: () {
                          // Navigate to the second screen using a named route.
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return profile_screen();
                              }));
                        },
                        padding: EdgeInsets.all(0.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),

                            child: Image.asset('images/bust.png')))));


                // Image.network(images[index]);
              },
            )
),
      ),
    );
  }
}
