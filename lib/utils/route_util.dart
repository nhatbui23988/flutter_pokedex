import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_project/ui/homepage/HomePageScreen.dart';
import 'package:pokedex_project/ui/pokedex/PokedexPageScreen.dart';
import 'package:pokedex_project/ui/splashpage/SplashPageScreen.dart';

enum Routes { splash, home, pokedex }

class AppRoutes {
  static Widget getScreen(Routes route) {
    switch (route) {
      case Routes.splash:
        return SplashPage();
      case Routes.home:
        return HomePage();
      case Routes.pokedex:
        return PokedexPage();
      default:
        return HomePage();
    }
  }

  static void pushRoute(BuildContext context, Routes route){
     Navigator.of(context).push(MaterialPageRoute(builder: (builder) => getScreen(route)));
  }
}
