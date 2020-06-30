import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getit/services/database.dart';

class LiveToken extends StatefulWidget {
  String userId;
  LiveToken({this.userId});

  @override
  _LiveTokenState createState() => _LiveTokenState(userId: userId);
}

class _LiveTokenState extends State<LiveToken> {
  String userId;
  int tokenNum;
  int presentToken;
  final _formkey6 = GlobalKey<FormState>();
  _LiveTokenState({this.userId});
  @override
  Widget build(BuildContext context) {
    bool check;
    return Scaffold(
      appBar: AppBar(title: Text("Live Token")),
      body: FutureBuilder(
          future: Firestore.instance
              .collection("LiveToken")
              .document(this.userId)
              .get()
              .then((data) => {
                    print("ima here 5"),
                    print(data.exists),
                    check = data.exists,
                    presentToken = data.data['Token']
                  }),
          builder: (context, snapshot) {
            print("ima here 6");
            print(check);
            try {
              if (check) {
                return Container(
                    child: Column(children: <Widget>[
                  Center(
                    child: Text("Enter Token No"),
                  ),
                  Center(
                    child: Form(
                        key: _formkey6,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  this.tokenNum = int.parse(val);
                                },
                                validator: (val) => val.length > 0
                                    ? null
                                    : "Enter Token Number",
                              ),
                            ),
                            RaisedButton(
                                child: Text("Update Token"),
                                onPressed: () {
                                  if (_formkey6.currentState.validate()) {
                                    DataBaseServices()
                                        .liveToken(this.userId, this.tokenNum)
                                        .then((data) => {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LiveToken(
                                                    userId: this.userId,
                                                  ),
                                                  // settings: RouteSettings(
                                                  //   arguments: [catgary[index],this.userid],
                                                  // ),
                                                ),
                                              )
                                            });
                                  }
                                }),
                            Text("Present Token Number $presentToken")
                          ],
                        )),
                  ),
                ]));
              } else {
                return RaisedButton(
                    child: Text("Start Creating Live Token"),
                    onPressed: () {
                      DataBaseServices()
                          .createliveTokenDB(widget.userId)
                          .then((data) => {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LiveToken(
                                      userId: this.userId,
                                    ),
                                    // settings: RouteSettings(
                                    //   arguments: [catgary[index],this.userid],
                                    // ),
                                  ),
                                )
                              });
                    });
              }
            } catch (e) {
              print(e);
            }

//           bool check ;

//           DataBaseServices().checkLiveTokenDB(userId).then(
//             (data)=>{
//               print("iam here"),
//               print(data),
//               check = data,

//             }

//           );
//         if(check){
// return Text("has Data");
//         }
//         else{
            return Text("");

            // }
          }),
      // body:StreamBuilder(
      //   stream: Firestore.instance.collection("LiveToken").document("Uid").get(),
      //   builder: (context,snapshot){

      //   }

      //   )
    );
  }
}
