import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'account_screen.dart';
import 'detailsPage.dart';


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
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

                onPressed:(null),
                padding: EdgeInsets.only(top:7.0),
                child: Image.asset('images/connects.png')))
      ],
    ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("bios").getDocuments();
    return qn.documents;
  }
  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: post,)));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getPosts(),
          builder: (_, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text('loading'),);
      }
      else{
    return ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (_, index){
    return GestureDetector(
    onTap: () => navigateToDetail(snapshot.data[index]),

    child: Padding(
    padding: EdgeInsets.only(top: 2.0),
    child: Card(
    color: Colors.black,
    margin: EdgeInsets.fromLTRB(2, 1, 2, 0),
    child: ListTile(
    leading: CircleAvatar(
    radius:28.0,
    backgroundColor: Colors.blueGrey,
    backgroundImage: NetworkImage(snapshot.data[index].data['picURL'])
    ),
    title: Text(
    snapshot.data[index].data['name'],
    style: TextStyle(color: Colors.teal) ),
    subtitle: Text(snapshot.data[index].data['blurb']),

    )
    )));


    //ListTile(
    // title: Text(snapshot.data[index].data['name']),
    //   onTap: () => navigateToDetail(snapshot.data[index]),
    //  );
    // });
    //  }
    // }
    });
    }}));
  }
}


//class DetailPage extends StatefulWidget {
//final DocumentSnapshot post;
//DetailPage({this.post});
//@override
//_DetailPageState createState() => _DetailPageState();
//}
//
//class _DetailPageState extends State<DetailPage> {
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        child: Card(
//          child: ListTile(
//            title: Text(widget.post.data['name']),
//            subtitle: Text(widget.post.data['blurb']),
//          ),
//        )
//    );
//  }
//}




