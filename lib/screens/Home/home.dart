import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getit/screens/Home/catgary.dart';
import 'package:getit/screens/Home/myAppotiments.dart';
import 'package:getit/screens/Home/showDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getit/screens/Registration/registrationOfUser.dart';
import 'package:getit/screens/ShareWidget/switchCardButton.dart';
import 'package:getit/screens/auth/wrapper.dart';
import 'package:getit/services/database.dart';

class Home extends StatefulWidget {
  String userid;

  Home({this.userid});

  @override
  _HomeState createState() {
    print("iaam2");
    // print(this.userid);

    return _HomeState(userid: this.userid);
  }
}

class _HomeState extends State<Home> {
  String userid;

  _HomeState({this.userid});
  bool isLeave = false;
  bool leaveStatus = false;

  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Future<FirebaseUser> getFirebaseUser() async {
  //   FirebaseUser user = await firebaseAuth.currentUser();
  //   print(user.uid+"iam here");
  //   print(user != null ? user.uid : null);
  // }\

  @override
  Widget build(BuildContext context) {
    
    // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    // Future<FirebaseUser> getFirebaseUser() async {
    //   FirebaseUser user = await firebaseAuth.currentUser();
    //   print(user.uid+"iam here");
    //   print(user != null ? user.uid : null);
    // }
    try {
      print(this.userid + "i am 4");
    } catch (e) {
      return Wrapper();
    }
    return Scaffold(
        drawer: ShowDrawer(
          userId: this.userid,
        ),
        appBar: AppBar(
          title: Text("Doctor guru"),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('Users')
                .document(this.userid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              // print(snapshot.data.exists.toString() +"eits");
              print(this.userid + "iamuserid");
              
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("loading data");
              } else if ((snapshot.connectionState == ConnectionState.active) &&
                  snapshot.data.exists) {
                print(snapshot.data.data["first Name"]);
                this.leaveStatus = snapshot.data.data["leave"];
                return Column(
                  children: <Widget>[
                    Text("Welcome Doctor"),
                    StreamBuilder(
                        stream: Firestore.instance
                            .collection("Appotiments")
                            .where("Doctor User ID", isEqualTo: this.userid)
                            .where("status", isEqualTo: "success")
                            .where("refund", isEqualTo: false)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            print("Loading");
                            return Text("Loading");
                          }
                          var userDocument = snapshot.data.documents;

                          return 
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: Column(children: <Widget>[
                                SizedBox(height: 5),
                                Text("New Appotiments",
                                    style: TextStyle(fontSize: 21)),
                                SizedBox(height: 10),
                                Text(
                                  userDocument.length.toString(),
                                  style: TextStyle(fontSize: 50),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: ButtonTheme(
                                    minWidth: double.infinity,
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                        ),
                                        color: Color.fromRGBO(43, 39, 240, 1),
                                        child: Text("Click to view",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyAppotiments(
                                                userId: this.userid,
                                              ),
                                              // settings: RouteSettings(
                                              //   arguments: [catgary[index],this.userid],
                                              // ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ]),
                            ),
                          );
                          
                        }),

                        SizedBox(height: 20,),

                        SwitchCardButton(leaveStatus: this.leaveStatus,userid: this.userid,),
                  ],
                );
                //  Catgagery(
                //   userid: this.userid,
                //   userName: snapshot.data.data["first Name"],

                // );
              } else {
                return RegistrationOfUser(uid: this.userid);
              }
              return SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Text("hi"),
                ],
              ));
            })
        // Catgagery(),
        );
  }
}
