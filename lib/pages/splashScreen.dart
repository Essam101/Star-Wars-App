import 'package:flutter/material.dart';
import 'dart:async';

import 'charactersScreen.dart';

class SplashScreen extends StatefulWidget {
  static const id = '/splash'; // home screen router-id

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashTime().then((status) {
      Navigator.pushReplacementNamed(context, CharactersScreen.id);
    });
  }

  // splash screen time
  splashTime() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          color: Color(0xFF1C1E22),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Image.asset("assets/images/StarWars.png",width: width/2,)
          )),
    );
  }
}
