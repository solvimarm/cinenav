import "package:flutter/material.dart";

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {

  List<String> images = <String>[];

  @override
  initState(){
    super.initState();
    images.add("assets/jackreacher.jpg");
    images.add("assets/alita.jpg");
    images.add("assets/creed.jpg");
    images.add("assets/spiderman.jpg");
  }

  Widget _buildAppBar(){
    return new AppBar(
      backgroundColor: Colors.transparent,
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

    );
  }

  Widget _buildBottomBar(){
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0.0,
      child: new Padding(
        padding: EdgeInsets.all(16.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RoundIconButton.large(
              icon: Icons.clear,
              color: Colors.red,
              onPressed: (){
                setState(() {
                  images.removeLast();
                });
              },
            ),
            RoundIconButton.large(
              icon: Icons.star,
              color: Colors.blue,
              onPressed: (){

              },
            ),
            RoundIconButton.large(
              icon: Icons.favorite,
              color: Colors.green,
              onPressed: (){
                setState(() {

                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardStack(){
    return  new Card(
      elevation: 0.0,
      child: new Container(
        child: new Center(
          child: images.isEmpty?
          new Text("No more Movies to show",
            style: new TextStyle(fontSize: 20.0),
          ):
          new Image.asset(images.last),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar: _buildAppBar(),
      body: _buildCardStack(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}
class ProfileCard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ProfileCardState();
  }
}
class _ProfileCardState extends State<ProfileCard>{

  Widget _buildBackground(){
    return new Image.asset(
        'assets/ironman3.jpg'
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _buildBackground()
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget{
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onPressed;

  RoundIconButton.large({
    this.icon,
    this.color,
    this.onPressed,
  }) : size = 60.0;
  RoundIconButton.small({
    this.icon,
    this.color,
    this.onPressed,
  }) : size = 50.0;

  RoundIconButton({
    this.icon,
    this.color,
    this.onPressed,
    this.size,
  });



  @override
  Widget build(BuildContext context) {
    return new Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: const Color(0x1100000),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: new Icon(
          icon,
          color: color,
        ),
        onPressed: onPressed,
      ),
    );
  }

}