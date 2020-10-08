import 'package:flutter/material.dart';
import 'package:star_wars/pages/characterDetailsScreen.dart';
import 'package:star_wars/pages/charactersScreen.dart';
import 'package:star_wars/pages/splashScreen.dart';

class Routes {
  // Routes of  all the screens of the program
  static final routes = <String, WidgetBuilder>{
    CharactersScreen.id: (context) => CharactersScreen(),
    CharacterDetailsScreen.id: (context) => CharacterDetailsScreen(),
    SplashScreen.id: (context) => SplashScreen(),
  };
}
