import "dart:async";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:smooth_star_rating/smooth_star_rating.dart";
import "auth.dart";


class RateMoviesHome extends StatefulWidget{
  final BaseAuth auth;
  RateMoviesHome({this.auth});

  @override

  State<StatefulWidget> createState() => RateMoviesHomeState();
}

class RateMoviesHomeState extends State<RateMoviesHome>{
  StreamSubscription<Event> _onNotRatedMovieAddedSubscription;
  StreamSubscription<Event> _onMovieInformationAddedSubscription;
  StreamSubscription<Event> _onNotRatedMovieRemovedSubscription;
  List<String> notRatedMovieList = new List();
  Map<dynamic, dynamic> movieInformations = new Map();

  _onNotRatedMovieAdded(Event event){
    setState(() {
      notRatedMovieList.add(event.snapshot.value);
    });
  }

  _onNotRatedRemoved(Event event){
    setState((){
      notRatedMovieList.remove(event.snapshot.value);
    });
  }

  _onMovieInformationAdded(Event event){
    movieInformations[event.snapshot.key] = event.snapshot.value;
  }

  String stripTitle(String title){
    return title.substring(0, title.length - 7);
  }

  @override

  initState(){
    super.initState();
    final notRatedReference = FirebaseDatabase.instance.reference().child("users").child(widget.auth.getCidString()).child("not_rated");
    final movieInformationReference = FirebaseDatabase.instance.reference().child("movies");

    _onNotRatedMovieAddedSubscription = notRatedReference.onChildAdded.listen(_onNotRatedMovieAdded);
    _onNotRatedMovieRemovedSubscription = notRatedReference.onChildRemoved.listen(_onNotRatedRemoved);
    _onMovieInformationAddedSubscription = movieInformationReference.onChildAdded.listen(_onMovieInformationAdded);
  }

  Widget build(BuildContext context){
    return new Scaffold(
      body: new ListView.builder(
        shrinkWrap: true,
        reverse: true,
        //controller: _listViewScrollController,
        itemCount: notRatedMovieList.length,
        itemBuilder: (buildContext, index){
          return new InkWell(
            child: new Container(
                padding: EdgeInsets.all(1.0),
                child: NotRatedMovieButton(stripTitle(movieInformations[notRatedMovieList[index]]["title"]), notRatedMovieList[index], movieInformations[notRatedMovieList[index]]["poster"], widget.auth.getCidString()),
            ),
          );
        },
      ),
    );
  }
}

class NotRatedMovieButton extends StatelessWidget {
  final String title;
  final String movieId;
  final String poster;
  final String userId;

  NotRatedMovieButton(this.title, this.movieId, this.poster, this.userId);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        sendRatingToDatabase(context);
      },
      child: Text(movieId + " : " + title),
    );
  }


  sendRatingToDatabase(BuildContext context) async {

    final rateReference = FirebaseDatabase.instance.reference().child("users").child(userId).child("rated");
    final recommendationReference = FirebaseDatabase.instance.reference().child("requests").child(userId).child("getRecommendations");

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RatingScreen(title, poster)),
    );

    if (result != null) {
      Map<dynamic, dynamic> ratings = new Map();

      await rateReference.once().then((DataSnapshot snapshot) {
        ratings = snapshot.value;
      });

      if (ratings == null) {
        Map<dynamic, dynamic> ratings = new Map();
        await rateReference.parent().once().then((DataSnapshot snapshot) {
          ratings = snapshot.value;
        });

        Map<dynamic, dynamic> newRate = new Map();
        newRate[movieId] = result;

        ratings["rated"] = newRate;

        rateReference.parent().set(
            ratings
        );

        Map<dynamic, dynamic> updateState = new Map();

        await recommendationReference.parent().parent().once().then((DataSnapshot snapshot){
          updateState = snapshot.value;
        });
        Map<String, dynamic> updateValue = new Map();
        updateValue["update"] = new DateTime.now().millisecondsSinceEpoch;
        Map<dynamic, dynamic> recommendationContainer = new Map();
        recommendationContainer["getRecommendations"] = updateValue;
        updateState[userId] = recommendationContainer;
        recommendationReference.parent().parent().set(updateState);

      }else {
        ratings[movieId] = result;
        rateReference.set(
            ratings
        );
        recommendationReference.child("update").set(new DateTime.now().millisecondsSinceEpoch);
      }
    }
  }
}

class RatingScreen extends StatefulWidget{
  final String title;
  final String poster;

  RatingScreen(this.title, this.poster);

  @override
  State<StatefulWidget> createState() => new RatingScreenState();
}

class RatingScreenState extends State<RatingScreen> {
  double rating = 2.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PosterImage(posterUrl: widget.poster),
            SmoothStarRating(
              size: 60.0,
              rating: rating,
              color: Colors.orange,
              borderColor: Colors.grey,
              starCount: 5,
              onRatingChanged: (rating){
                setState((){
                  this.rating = rating;
                });
              },
            ),
            Container(height: 20.0),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context, rating);
              },
              child: Text("Send rating"),
            ),
          ],
        ),
      ),
    );
  }
}

class PosterImage extends StatelessWidget{
  final String posterUrl;

  PosterImage({this.posterUrl});

  @override
  Widget build(BuildContext context){
    if(posterUrl == null){
      return Image.asset("assets/Nodata.png");
    }else{
      return Image.network(
        posterUrl,
        height: 400.0,
        width: 200.0,
        fit: BoxFit.contain,
      );
    }
  }
}
