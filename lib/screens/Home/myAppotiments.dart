import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getit/models/appotimentModel.dart';
import 'package:getit/services/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAppotiments extends StatefulWidget {
  String userId;
  MyAppotiments({this.userId});
  @override
  _MyAppotimentsState createState() => _MyAppotimentsState(userId: this.userId);
}

class _MyAppotimentsState extends State<MyAppotiments> {
  bool showErr = false;
  String userId;
  int tokenNum;
  _MyAppotimentsState({this.userId});

  List<AppotimentModel> data = [];
  @override
  Widget build(BuildContext context) {
    print(this.userId + " iam ffrom appointents");
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Appointments"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("Appotiments")
            .where("Doctor User ID", isEqualTo: userId)
            .where("status", isEqualTo: "success")
            .where("refund", isEqualTo: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            print("Loading");
            return Text("Loading");
          }
          var userDocument = snapshot;
          if (userDocument.data.documents.length == 0) {
            return Text("No Appotiment are there");
          }

          this.data = (userDocument.data.documents.map((useData) {
            String getdatamap;

            Firestore.instance
                .collection("Users")
                .document(useData["Patent Uid"])
                .get()
                .then((data) => {
                      print(data.data),
                      getdatamap = data.data["first Name"],
                      print(useData["status"]),
                    });
            print(getdatamap);
            return AppotimentModel(useData["status"], useData["CompletedAt"],
                appotimentId: useData.documentID,
                doctorid: useData["Doctor User ID"],
                tokenNum: useData["token"],
                patienName: useData["patient Name"],
                bookedSlot: useData["appotimentSlot"],
                patienMobileNum: useData["paatient Num"],
                patientGender: useData["patient gender"],
                patientAge: useData["patient age"]
                // patient age

                //  useData["Doctor User ID"],
                //  useData["status"],
                );
          })).toList();
          return SingleChildScrollView(
            child: Column(
                children: data.map((appotiment) {
              print(appotiment.datenow);
              // return Text(appotiment.datenow.toString());
              return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text("\n Patient Name: " + appotiment.patienName + " \n"),
                      // Text(" Patient age: " + appotiment.patientAge.toString() + " \n"),
                      Text(" Patient gender: " + appotiment.patientGender + " \n"),
                      Text("booked slot: " + appotiment.bookedSlot + " \n"),
                      // Text("\n Doctor Id: " + appotiment.doctorid + " \n"),
                      // Text(appotiment.datenow + "\n"),
                      Text("Still pending with doctor \n"),
                      appotiment.tokenNum != 0
                          ? Text("your token Number :" +
                              appotiment.tokenNum.toString())
                          :
                          // RaisedButton(
                          //   child: Text("Cancel"),
                          //   onPressed: (){
                          //     DataBaseServices().refundTheMoney(appotiment.appotimentId);

                          // }),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      DataBaseServices().refundTheMoney(
                                          appotiment.appotimentId);
                                    }),
                                SizedBox(
                                  width: 20,
                                ),
                                RaisedButton(
                                    child: Text("Assign token"),
                                    onPressed: () {
                                      print("i am here");

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            final _formkey6 =
                                                GlobalKey<FormState>();
                                            return AlertDialog(
                                              title: Text('Assign Token'),
                                              content: SingleChildScrollView(
                                                child:
                                                    ListBody(children: <Widget>[
                                                  Form(
                                                    key: _formkey6,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (val) =>
                                                          val.length >= 1
                                                              ? null
                                                              : "Enter Token",
                                                      onChanged: (val) {
                                                        this.tokenNum =
                                                            int.parse(val);
                                                      },
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text('Assign'),
                                                  onPressed: () {
                                                    if (_formkey6.currentState
                                                        .validate()) {
                                                      dynamic result =
                                                          DataBaseServices()
                                                              .updateToken(
                                                                  this.tokenNum,
                                                                  appotiment
                                                                      .appotimentId);
                                                      if (result != null) {
                                                        Fluttertoast.showToast(
                                                            msg: "Sucess",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);

                                                        Navigator.of(context)
                                                            .pop();
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "DataBase Error",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Form should br verifed",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    }
                                                    print(this.tokenNum);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    })
                              ],
                            )
                    ],
                  ));
            }).toList()),
          );
        },
      ),
    );
  }
}
