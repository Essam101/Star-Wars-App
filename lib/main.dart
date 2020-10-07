import 'package:flutter/material.dart';
import 'package:star_wars/pages/characterDetailsScreen.dart';
import 'package:star_wars/pages/charactersScreen.dart';
import 'package:star_wars/pages/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        CharactersScreen.id: (context) => CharactersScreen(),
        CharacterDetailsScreen.id: (context) => CharacterDetailsScreen(),
        SplashScreen.id: (context) => SplashScreen(),
       },
    );
  }
}
