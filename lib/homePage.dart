import "package:flutter/material.dart";
import "auth.dart";
import "package:flutter/cupertino.dart";

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

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
        title: new Text("Cine Nav"),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Logout",
                style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: _signOut,
          ),
        ],
      ),
      body: new Container(
          child: new Center(
            child: new Text("Welcome", style: new TextStyle(fontSize: 32.0)),
          )
      ),
      bottomNavigationBar: new CupertinoTabBar(
        activeColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("Rate"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            title: Text("News"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text("My Page"),
          ),
        ],
      ),
    );
  }
}


