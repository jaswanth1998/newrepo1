import 'package:flutter/material.dart';






import 'package:getit/screens/Home/home.dart';
import 'package:getit/screens/Home/seeDoctotr.dart';
import 'package:getit/screens/auth/auth.dart';
import 'package:getit/screens/auth/wrapper.dart';
import 'package:getit/screens/editprofile/EditProfile.dart';
import 'package:getit/screens/livetoken/LiveToken.dart';
import 'package:getit/screens/showSplash/showSplash.dart';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:getit/model/user.dart';
// import 'package:getit/screens/wrapper.dart';
// import 'package:getit/services/auth.dart';
// import 'package:provider/provider.dart';
// import './signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
 

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState(){
    super.initState();
      _messaging.getToken().then((token) {

        
          Future<SharedPreferences> setData = SharedPreferences.getInstance();
              setData.then(
                (data)=>{
                  data.setString("User Notification Token", token)
                }
              );
                   
      print(token);
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  MaterialApp(
            // debugShowCheckedModeBanner: false,
        home:ShowSplash(),
          routes: <String, WidgetBuilder>{
      '/authScren': (BuildContext context) => new Auth(),
      '/wrapper': (BuildContext context) => new Wrapper(),
      '/Home': (BuildContext context) => new Home(),
      '/Doctor': (BuildContext context) => new SeeDoctor(),
      '/LiveToken': (BuildContext context) => new LiveToken(),
      '/EditProfile': (BuildContext context) => new EditProfile()
    },
      );
  }
}