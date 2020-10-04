import 'package:flutter/material.dart';
// import 'package:getit/screens/ShareWidget/loding.dart';
import 'package:getit/screens/auth/displayFrom.dart';
import 'package:getit/screens/auth/registerAuth.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  // final _formkey1 = GlobalKey<FormState>();
  String phoneNum = "";
  bool checkOtp = true;
  bool mask = false;
  bool startlog = true;
  bool checkLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Text(
              "Welcome to  Doctor's Token",
              style: TextStyle(fontSize: 34, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            new Image.asset('assests/icon.png')
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.lightBlueAccent,
        child: Wrap(
            // margin: EdgeInsets.all(20),

            children: <Widget>[
             startlog? Center(
               child: Column(children: <Widget>[
                  RaisedButton(child: Text("Login"), onPressed: () {
                    setState(() {
                      this.startlog = false;
                    });
                  }),
                  RaisedButton(child: Text("Register"), onPressed: () {
 setState(() {
                      this.startlog = false;
                      this.checkLogin = false;
                    });
                  }),
                ]),
             ):
              checkLogin?DisplayFrom():RegisterFromAuth()
            ]),
      ),
    );
  }

  checkStateOfframeHere() {}
}
