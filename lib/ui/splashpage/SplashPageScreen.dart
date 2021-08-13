import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex_project/ui/pokedex/PokedexPageScreen.dart';
import 'package:pokedex_project/utils/image_utils.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (buildContext) => PokedexPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Pokedex",
                style: TextStyle(
                    fontSize: 42,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(10, 8),
                          color: Colors.blueGrey,
                          blurRadius: 8)
                    ]),
              ),
            ),
            Image(image: ImageUtils.pika_run)
          ],
        ),
      ),
    );
  }
}
