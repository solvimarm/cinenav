import "package:flutter/material.dart";
import "auth.dart";
import "package:flutter/cupertino.dart";
import "recommendation.dart";
import "ratingPage.dart";
import "userRate.dart";


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
              new Recommendation(),//Center(child: Text("Home")),
              new RatingPage(),
              Center(child: RatingHome(userRating("18",'',''))),
              Center(child: Text("My Page")),
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



/*
class HomePage extends StatefulWidget{
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageType _pageType = PageType.home;
  int _currentIndex = 0;

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
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
            child: new Text("Welcome"),
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
        currentIndex: _currentIndex,
        onTap: (_currentIndex){
          switch(_currentIndex){
            case 0:
              setState((){
                _pageType = PageType.home;
              });
              break;
            case 1:
              setState((){
                _pageType = PageType.rate;
              });
              break;
            case 2:
              setState((){
                _pageType = PageType.news;
              });
              break;
            case 3:
              setState((){
                _pageType = PageType.myPage;
              });
              break;
          }
        }
      ),
    );
  }
}
 */