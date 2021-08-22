import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/ui/homepage/HomePageScreen.dart';
import 'package:pokedex_project/ui/pokedex/PokedexPageScreen.dart';
import 'package:pokedex_project/ui/pokemondetailpage/PokemonDetailPage.dart';
import 'package:pokedex_project/ui/splashpage/SplashPageScreen.dart';

//export PATH="$PATH:/Users/NhatBui/flutter/bin"
void main() {
  runApp(MaterialApp(
    home: kDebugMode ? DebugScreen() : SplashPage(),
    // home: PokemonDetailPage(),
  ));
}

class DebugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, top: 70, bottom: 12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (buildContext) => SplashPage())),
                  child: Text("Splash page")),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (buildContext) => HomePage())),
                  child: Text("Home page")),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (buildContext) => PokedexPage())),
                  child: Text("Pokedex page")),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (buildContext) => PokemonDetailPage(1, null))),
                  child: Text("Pokemon detail")),
            ],
          ),
        ),
      ),
    );
  }
}
