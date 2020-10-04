import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getit/models/appotimentModel.dart';
import 'package:getit/services/database.dart';

class AssignToken extends StatefulWidget {
  String userId;
  AssignToken({this.userId});
  @override
  _AssignTokenState createState() => _AssignTokenState(userId: this.userId);
}


class _AssignTokenState extends State<AssignToken> {
  bool showErr = false;
  String userId;
  int tokenNum;

  
  _AssignTokenState({this.userId});
  List<AppotimentModel> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assign Tokens"),
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          StreamBuilder(
             stream: Firestore.instance
            .collection("Appotiments")
            .where("Doctor User ID", isEqualTo: userId)
            .where("status", isEqualTo: "success")
            .where("refund", isEqualTo: false)
            .where("token", isEqualTo: 0)
            .orderBy("CompletedAt")

            .snapshots(),
             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                            print("Loading");
                            return Text("Loading");
                          }
                         var userDocument = snapshot;
                           if (snapshot.data.documents.length == 0) {
            return Text("No Appointments");
          }

                   this.data = (userDocument.data.documents.map((useData) {
            String getdatamap;

      
            print(getdatamap);
            return AppotimentModel(
              useData["status"], useData["CompletedAt"],
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
          

          return 
             Column(
               children: data.map((appotiment) {
                 print(appotiment.datenow);
                 return Card(
                   margin: EdgeInsets.all(10),
                   child: Column(
                     children: <Widget>[
                          Text("\n Patient Name: " + appotiment.patienName + " \n"),
                      Text(" Patient gender: " + appotiment.patientGender + " \n"),
                      Text("Booked Slot: " + appotiment.bookedSlot + " \n"),
 appotiment.tokenNum != 0
                          ? Text("your token Number :" +
                              appotiment.tokenNum.toString())
                          :
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
                                                              "Form should be verified",
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
               }).toList());
      

             }
             ),
        ],
      ))
    );
  }
}