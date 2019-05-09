import "package:flutter/material.dart";
import "package:firebase_database/firebase_database.dart";
import "dart:async";

class listTest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => listTestState();
}

class listTestState extends State<listTest>{
  final testReference = FirebaseDatabase.instance.reference().child("z-test").child("users").child("18").child("not_rated");
  StreamSubscription<Event> _onNotRatedAddedSubscription;
  StreamSubscription<Event> _onNotRatedRemovedSubscription;

  List<String> testList = new List();

  _onNotRatedAdded(Event event){
    setState(() {
      testList.add(event.snapshot.value);
    });
  }

  _onNotRatedRemoved(Event event){
    setState(() {
      testList.remove(event.snapshot.value);
    });
  }

  @override
  initState(){
    _onNotRatedAddedSubscription = testReference.onChildAdded.listen(_onNotRatedAdded);
    _onNotRatedRemovedSubscription = testReference.onChildRemoved.listen(_onNotRatedRemoved);
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView.builder(
          itemCount: testList.length,
          itemBuilder: (context, index){
            if(testList[index] != "null"){
              return Text("$index : ${testList[index]}");
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() async{

          final updateReference = FirebaseDatabase.instance.reference().child("z-test").child("requests").child("18").child("getRecommendations");

          Map<dynamic, dynamic> updateState = new Map();
          await updateReference.once().then((DataSnapshot snapshot) {
            updateState = snapshot.value;
          });

          if(updateState == null){
            await updateReference.parent().parent().once().then((DataSnapshot snapshot){
              updateState = snapshot.value;
            });
            Map<String, dynamic> updateValue = new Map();
            updateValue["update"] = new DateTime.now().millisecondsSinceEpoch;
            Map<dynamic, dynamic> recommendationContainer = new Map();
            recommendationContainer["getRecommendations"] = updateValue;
            updateState["18"] = recommendationContainer;
            updateReference.parent().parent().set(updateState);
          }else{
            updateReference.child("update").set(new DateTime.now().millisecondsSinceEpoch);
          }
        }
      )
    );
  }
}