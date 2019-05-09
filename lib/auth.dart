import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
  String getCidString();
}

class Auth implements BaseAuth{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String currentId;

  Future<String> signInWithEmailAndPassword(String email, String password) async{
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    currentId = user.uid.toString();
    //return user.uid;
    return currentId;
  }

  Future<String> createUserWithEmailAndPassword(String email, String password) async{
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    currentId = user.uid.toString();
    //return user.uid;
    return currentId;
  }

  Future<String> currentUser() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    currentId = user.uid.toString();
    //return user.uid;
    return currentId;
  }

  Future<void> signOut() async{
    currentId = null;
    return _firebaseAuth.signOut();
  }

  String getCidString(){
    if(currentId == null){
      return "no current Id";
    }else return currentId;
  }

}
