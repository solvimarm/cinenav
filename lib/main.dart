import 'package:flutter/material.dart';
import 'auth.dart';
import 'rootPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      //home: FrontPage(),
      home: RootPage(auth: new Auth()),
    );
  }
}
