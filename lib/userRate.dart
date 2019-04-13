import "package:flutter/material.dart";
import "package:firebase_database/firebase_database.dart";

class userRating{
  String _id;
  String _rated;
  String _not_rated;

  userRating(this._id, this._rated, this._not_rated);

  userRating.map(dynamic obj){
    this._id = obj['id'];
    this._rated = obj['rated'];
    this._not_rated = obj['not_rated'];
  }

  String get id => _id;
  String get rated => _rated;
  String get not_rated => _not_rated;

  userRating.fromSnapshot(DataSnapshot snapshot){
    _id = snapshot.key;
    _rated = snapshot.value['rated'];
    _not_rated = snapshot.value['not_rated'];
  }
}

class Reccomendation{
  String _id;
  String _title;

  Reccomendation.fromSnapshot(DataSnapshot snapshot){
    _id = snapshot.key;
    _title = snapshot.value[_id];
  }

}


class RatingHome extends StatefulWidget{
  final userRating userRate;
  RatingHome(this.userRate);

  @override
  State<StatefulWidget> createState() => new _RatingHomeState();
}

final ratesReference = FirebaseDatabase.instance.reference().child('test');
final recommendationReference = FirebaseDatabase.instance.reference().child('requests').child('18').child('getMovies');

class _RatingHomeState extends State<RatingHome>{
  List<Reccomendation> ReccomendationList = new List();

  _RatingHomeState(){
    recommendationReference.onChildAdded.listen(onReccomendationAdded);
  }
  onReccomendationAdded(Event event){
    setState(() {
      ReccomendationList.add(new Reccomendation.fromSnapshot(event.snapshot));
    });
  }

  @override
  Widget build(BuildContext context){
    return Column(
     children: <Widget>[
       Center(
         child: RaisedButton(
           child: Text('Send Query'),
           onPressed: () {
             ratesReference.push().set({
               "title": "kkkkk",
               "author": "ddddd",
             });
           },
         ),
       ),
      Text("kkkk"),
      ],
    );
  }
}