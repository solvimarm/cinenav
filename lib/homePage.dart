import "package:flutter/material.dart";
import "auth.dart";
import "package:flutter/cupertino.dart";
import "recommendation.dart";
import "rateMovies.dart";
import "package:firebase_database/firebase_database.dart";
import "test.dart";
import "testRate.dart";

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut, this.currentId});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  String currentId;

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white70,
        elevation: 0.0,
        leading: new Icon(
          Icons.local_movies,
          size: 30.0,
          color: Colors.blueAccent,
        ),
        title: new Text(
          "CineNav",
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20.0,
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Logout",
                style: new TextStyle(fontSize: 17.0, color: Colors.black)),
            onPressed: _signOut,
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            children:[
              new Recommendation(auth: auth),
              new RateMoviesHome(auth: auth),
              new listTest(), //Center(child: Text("To be construct")),
              Center(child: Text(auth.getCidString())),
            ],
          ),
          bottomNavigationBar: Container(
            color: Colors.white70,
            child: TabBar(
              indicatorColor: Colors.black,
              tabs:[
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.star)),
                Tab(icon: Icon(Icons.new_releases)),
                Tab(icon: Icon(Icons.account_circle)),
              ],
            ),
          ),
        ),
      ),

    );
  }
}