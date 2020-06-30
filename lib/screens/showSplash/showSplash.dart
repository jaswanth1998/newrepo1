import 'package:flutter/material.dart';
import 'dart:async';

class ShowSplash extends StatefulWidget {
  @override
  _ShowSplashState createState() => _ShowSplashState();
}

class _ShowSplashState extends State<ShowSplash> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/wrapper');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(0, 152, 207, 1),
        child: Center(
            heightFactor: double.infinity,
            child: ListView(
              shrinkWrap: true,
              
          children: <Widget>[
             Text(
              "Welcome to",
              style: TextStyle(color: Colors.white, fontSize: 32),
              textAlign: TextAlign.center,
            ),
            new Image.asset('assests/splash.gif'),
            Text(
              "Doctor Guru",
              style: TextStyle(color: Colors.white, fontSize: 32),
              textAlign: TextAlign.center,
            ),
          ],
        )),
      ),
    );
  }
}
