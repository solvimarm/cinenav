import 'dart:async';
import 'package:flutter/material.dart';
import "package:firebase_database/firebase_database.dart";
import "auth.dart";


class Recommendation extends StatefulWidget{
  final BaseAuth auth;
  Recommendation({this.auth});
  @override
  State<StatefulWidget> createState() => new _RecommendationState();
}

class _RecommendationState extends State<Recommendation>{
  final movieInformationReference = FirebaseDatabase.instance.reference().child('movies');
  StreamSubscription<Event> _onRecommendationAddedSubscription;
  Map<dynamic, dynamic> recommendationList = new Map();
  List<String> recommendationKeys = new List();

  void _onRecommendationAdded(Event event){
    setState(() {
      recommendationList[event.snapshot.key] = event.snapshot.value;
      recommendationKeys.add(event.snapshot.key);
    });
  }

  @override

  initState(){
    super.initState();

    final recommendationReference = FirebaseDatabase.instance.reference().child('requests').child(widget.auth.getCidString()).child('getRecommendations').child("data");

    _onRecommendationAddedSubscription = recommendationReference.onChildAdded.listen(_onRecommendationAdded);
  }

  Widget build(BuildContext context){
    return ListView.builder(
        itemCount: recommendationKeys.length, //Movies.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.all(10.0),
            title: new Text(recommendationList[recommendationKeys[index]]["title"]),
            trailing: ImageProvider(recommendationList[recommendationKeys[index]]["poster"]),
          );
        }
    );
  }
}

class ImageProvider extends StatelessWidget{
  final String ImageUrl;
  ImageProvider(this.ImageUrl);
  @override
  Widget build(BuildContext context){
    if(ImageUrl != null){
      return Image.network(
        ImageUrl,
        height: 40.0,
        width: 40.0,
        fit: BoxFit.cover,
      );
    }else{
      return Image.asset(
        'assets/Nodata.png',
        height: 40.0,
        width: 40.0,
        fit: BoxFit.cover,
      );
    }
  }
}
