import 'package:flutter/material.dart';
import 'package:getit/caseTest/upiTest.dart';
import 'package:getit/screens/Home/home.dart';
import 'package:getit/screens/Registration/registrationOfUser.dart';
import 'package:getit/screens/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool checkUser = false;
  @override
  Widget build(BuildContext context) {
    //  FirebaseAuth.instance.currentUser().then((user){
    //    if(user == null){
    //      print(user);
    //      setState(() {
    //        this.checkUser = false;
    //      });
    //    }else{
    //      print(user);
    //      this.checkUser = true;

    //    }
    //  }) ;

    return Scaffold(
        // appBar: AppBar(),
        body:
            // );
            StreamBuilder<FirebaseUser>(
                stream: FirebaseAuth.instance.onAuthStateChanged,
                builder: (context, snapshot) {
                  // print(snapshot.data.uid);
                  try {
                    if (snapshot.data == null) {
                      
                      return Auth();
                    } else {
                      Future<SharedPreferences> setData =
                          SharedPreferences.getInstance();
                      setData.then((data) => {
                            // data.setString(
                            //     "patient phoneNum", snapshot.data.phoneNumber),
                            data.setString("patient Uid", snapshot.data.uid)
                          });
                      snapshot.data.phoneNumber;
                      return Home(
                        userid: snapshot.data.uid,
                      );
                    }
                  } catch (e) {
                    return Auth();
                  }
                }));
  }
}
