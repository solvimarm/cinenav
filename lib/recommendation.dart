import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:firebase_database/firebase_database.dart";

class Recommendation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _RecommendationState();
}

final recommendationReference = FirebaseDatabase.instance.reference().child('requests').child('18').child('getMovies').child("data"); // "18" going to change user id

class _RecommendationState extends State<Recommendation>{
  Map<dynamic, dynamic> Movies;
  String PosterUrl;


  void initState(){
    super.initState();
    initRecommendation();
  }

  initRecommendation() async {
    await recommendationReference.once().then((DataSnapshot snapshot){
      Movies = snapshot.value;
    });
  }

  @override
  Widget build(BuildContext context){
    return new ListView.builder(
      itemCount: 5, //Movies.length,
      itemBuilder: (BuildContext context, int index) {
        initRecommendation();
        return ListTile(
          contentPadding: EdgeInsets.all(10.0),
          title: new Text(Movies.keys.elementAt(index) + " : " + Movies.values.elementAt(index)),
          trailing: FutureBuilder<Poster>(
            future: fetchPoster("Ghost in the Shell"), // going to use trimmed Movies.values
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Image.network(
                  snapshot.data.poster,
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                );
              }else if(snapshot.hasError){
                return Text("${snapshot.error}");
              }
            }
          )
        );
      }
    );
  }
}

class Poster{
  String poster;

  Poster._({this.poster});

  Poster.fromJson(Map<String, dynamic> json):
    poster =json['Poster'];
}

Future<Poster> fetchPoster(String MovieTitle) async {
  final response = await http.get('http://omdbapi.com/?apikey=a5b3ea45&t=$MovieTitle');

  if(response.statusCode == 200){
    return Poster.fromJson(json.decode(response.body));
  }else{
    throw Exception('Failed to load');
  }
}