import 'package:flutter/material.dart';

import 'package:getit/models/appotimentModel.dart';
import 'package:getit/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainRefundPage extends StatefulWidget {
  String doctorId;
  MainRefundPage({this.doctorId});

  @override
  _MainRefundPageState createState() => _MainRefundPageState(doctorId: doctorId);
}

class _MainRefundPageState extends State<MainRefundPage> with SingleTickerProviderStateMixin{
    bool showErr = false;
  String userId;
  int tokenNum;
  List<AppotimentModel> data = [];

  String doctorId;
   final List<Tab> myTabs = <Tab>[
    Tab(text: 'To Refund'),
    Tab(text: 'Refunded'),
  ];

   TabController _tabController;
  _MainRefundPageState({this.doctorId});


@override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

 @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Status"),
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          if(tab.text == "To Refund"){
             return StreamBuilder(
        stream: Firestore.instance
            .collection("Appotiments")
            .where("Doctor User ID", isEqualTo: userId)
            .where("status", isEqualTo: "success")
            .where("refund", isEqualTo: true)
            .where("refunded", isEqualTo: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            print("Loading");
            return Text("Loading");
          }
          var userDocument = snapshot;

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
            return AppotimentModel(
              useData["status"], useData["CompletedAt"],
              appotimentId: useData.documentID,
              doctorid: useData["Doctor User ID"],
              tokenNum: useData["token"],

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
                      Text("\n Doctor Id:   " + appotiment.doctorid + " \n"),
                      Text(appotiment.datenow + "\n"),
                      Text("Still pending with Doctor \n"),
                      appotiment.tokenNum != 0
                          ? Text("your token Number :" +
                              appotiment.tokenNum.toString())
                          : RaisedButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                DataBaseServices()
                                    .refundTheMoney(appotiment.appotimentId);
                              }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            child: Text("Refund Sucess"),
                            onPressed: (){
                            DataBaseServices().refundedTheMoney(appotiment.appotimentId);
                          })
                        ],
                      )
                    ],
                  ));
            }).toList()),
          );
        },
      );




          }else
          {
             return StreamBuilder(
        stream: Firestore.instance
            .collection("Appotiments")
            .where("Doctor User ID", isEqualTo: userId)
            .where("status", isEqualTo: "success")
            
            .where("refunded", isEqualTo: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            print("Loading");
            return Text("Loading");
          }
          var userDocument = snapshot;

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
            return AppotimentModel(
              useData["status"], useData["CompletedAt"],
              appotimentId: useData.documentID,
              doctorid: useData["Doctor User ID"],
              tokenNum: useData["token"],

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
                      Text("\n Doctor Id:   " + appotiment.doctorid + " \n"),
                      Text(appotiment.datenow + "\n"),
                      Text("Still pending with Doctor \n"),
                      appotiment.tokenNum != 0
                          ? Text("your token Number :" +
                              appotiment.tokenNum.toString())
                          : RaisedButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                DataBaseServices()
                                    .refundTheMoney(appotiment.appotimentId);
                              }),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: <Widget>[
                      //     RaisedButton(
                      //       child: Text("Refund Sucess"),
                      //       onPressed: (){
                      //       DataBaseServices().refundedTheMoney(appotiment.appotimentId);
                      //     })
                      //   ],
                      // )
                    ],
                  ));
            }).toList()),
          );
        },
      );
          }
          final String label = tab.text.toLowerCase();
          return Center(
            child: Text(
              'This is the $label tab',
              style: const TextStyle(fontSize: 36),
            ),
          );
        }).toList(),
      ),
    );
  }
}



                          // RaisedButton(
                          //     child: Text("Cancel"),
                          //     onPressed: () {
                          //       DataBaseServices()
                          //           .refundTheMoney(appotiment.appotimentId);
                          //     }),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          // RaisedButton(
                          //     child: Text("Assign token"),
                          //     onPressed: () {
                          //       print("i am here");

                          //       showDialog(
                          //           context: context,
                          //           builder: (BuildContext context) {
                          //             final _formkey6 = GlobalKey<FormState>();
                          //             return AlertDialog(
                          //               title: Text('Assign Token'),
                          //               content: SingleChildScrollView(
                          //                 child: ListBody(children: <Widget>[
                          //                   Form(
                          //                     key: _formkey6,
                          //                     child: TextFormField(
                          //                       keyboardType:
                          //                           TextInputType.number,
                          //                       validator: (val) =>
                          //                           val.length >= 1
                          //                               ? null
                          //                               : "Enter Token",
                          //                       onChanged: (val) {
                          //                         this.tokenNum =
                          //                             int.parse(val);
                          //                       },
                          //                     ),
                          //                   ),
                          //                 ]),
                          //               ),
                          //               actions: <Widget>[
                          //                 FlatButton(
                          //                   child: Text('Cancel'),
                          //                   onPressed: () {
                          //                     Navigator.of(context).pop();
                          //                   },
                          //                 ),
                          //                 FlatButton(
                          //                   child: Text('Assign'),
                          //                   onPressed: () {
                          //                     if (_formkey6.currentState
                          //                         .validate()) {
                          //                       dynamic result =
                          //                           DataBaseServices()
                          //                               .updateToken(
                          //                                   this.tokenNum,
                          //                                   appotiment
                          //                                       .appotimentId);
                          //                       if (result != null) {
                          //                         Navigator.of(context).pop();
                          //                       }
                          //                     }
                          //                     print(this.tokenNum);
                          //                   },
                          //                 ),
                          //               ],
                          //             );
                          //           });
                          //     })