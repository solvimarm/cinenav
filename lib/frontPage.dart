import "package:flutter/material.dart";

class FrontPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: FrontPageContent(),
    );
  }
}

class FrontPageContent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar:new AppBar(
        title: new Text("Front Page"),
      ),
      body: new Padding(
        padding: new EdgeInsets.symmetric(vertical:0.0, horizontal: 0.0),
        child: frontPageBody,
      ),
    );
  }

  static Widget upperSection = new Expanded(
    child: new Container(
      padding: new EdgeInsets.all(8.0),
      color: Colors.teal,
      child: new Center(
        child: new Text("Cine Nav"),
      ),
    ),
  );

  static Widget lowerSection = new Expanded(
    child: new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
        children: <Widget>[
          LoginRegisterButton("Login with Google"),
          LoginRegisterButton("Login with Facebook"),
          LoginRegisterButton("Register"),
        ],
      ),
    ),
  );

  Widget frontPageBody = new Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      upperSection,
      lowerSection,
    ],
  );
}

class LoginRegisterButton extends StatelessWidget{
  final String buttonLabel;
  LoginRegisterButton(this.buttonLabel);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      color: Colors.amber,
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget> [
          new GestureDetector(
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}