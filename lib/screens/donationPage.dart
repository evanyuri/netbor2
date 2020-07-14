import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:io';
import "package:http/http.dart";
import 'package:flutter/material.dart';
import '../services/stripe.dart';

String email = '';
String password = '';
String error = '';
final _formkey = GlobalKey<FormState>();

String publickey =  "pk_test_51H3GPGBOJevGOlIOTOUsDAOZtsdY77Cksy53CRJdyjBsoCaW4a6weH7sPdazNO9FcgBJOS5h36pAJe1lUTrIkIGJ00zKr4w1gy";
String secretkey =  "sk_test_51H3GPGBOJevGOlIOY1QqYah5HCgTmzrB6OrlQvfizherH0CBHhSwmOsqEeoAsdYpgQZr1p7Di5O4zcZGtr2MWiqH00q4IQNRax";


class donationPage extends StatefulWidget {

  @override
  donationPageState createState() =>donationPageState();
}

class donationPageState extends State<donationPage> {


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        body: SafeArea(

          child: ListView(
              padding: EdgeInsets.only(top: 20.0, right: 10, left: 10),
              children: <Widget>[
                Image.asset('images/Logo.png', height: 90, width: 90),
                Center(
                    child: Text(
                      'Donate to Netbor',
                      style: TextStyle(
                        fontFamily: '',
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(height: 10,),
                Center(
                    child: Text(
                      'Netbor is a community supported app. We do not sell your data, becasue we think your data belongs to you. However, we need money to survive. We currently survive on the small donations we receive from people like you.'
                          ' Please help keep Netbor free for everyone to enjoy by providing a donation to the cause:',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: '',
                        fontSize: 13.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 10.0, right:2, left: 2),

                        child: ButtonTheme(
                                child: RaisedButton(
                                color: Colors.teal,
                                child: Text('\$5'),
                                onPressed: (null)
                            ))),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, right:2, left: 2),
                        child: ButtonTheme(
                            child: RaisedButton(
                                color: Colors.teal,
                                child: Text('\$10'),
                                onPressed: (null)
                            ))),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, right:2, left: 2),
                        child: ButtonTheme(
                            child: RaisedButton(
                                color: Colors.teal,
                                child: Text('\$20'),
                                onPressed: (null)
                            ))),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, right:2, left: 2),
                        child: ButtonTheme(
                            child: RaisedButton(
                                color: Colors.teal,
                                child: Text('\$100'),
                                onPressed: (null)
                            )))
                  ],
                ),
                Form(
                    child: Column(
                      children: <Widget>[
                        Text(error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        Form(
                            child: TextFormField(
                                obscureText: true,
                                validator: (val) => val.length < 6  ? 'Enter a password 6+ chars long' : null,
                                onChanged: (val) {setState(() => password = val);},
                                style: TextStyle(
                                  decorationColor: Colors.white,
                                  color: Colors.white,
                                ),
                                decoration: const InputDecoration(
                                  hintText: '\$ Custom Amount (USD)',
                                  labelText: null,
                                ))),

                      ],
                    )
                ),

                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: ButtonTheme(
                        minWidth: 200,
                        child: RaisedButton(
                          color: Colors.teal,
                          child: Text('Donate'),
                          onPressed: (null)
                        ))),
              ]),
        ))
    ;
  }
}
