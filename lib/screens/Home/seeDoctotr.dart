import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:getit/models/doctorUserModel.dart';
import 'package:getit/screens/ShareWidget/shareCard.dart';
import 'package:getit/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeeDoctor extends StatefulWidget {
  String userid;

  SeeDoctor({this.userid});
  @override
  _SeeDoctorState createState() => _SeeDoctorState(userid: this.userid);
}

class _SeeDoctorState extends State<SeeDoctor> {
  String userid;

  _SeeDoctorState({this.userid});

  // final brews = Provider.of<List<Brew>>(context)??[];
  List<DoctorUserModel> data;
  @override
  Widget build(BuildContext context) {
    // final doctor = Provider.of<List<QuerySnapshot>>(context)??[];

    // final String todo = ModalRoute.of(context).settings.arguments;

    //  bool user =  DataBaseServices().getData();
    // print(user);
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("data"),
    //   ),
    //   body: Text(todo),
    // );

    return Scaffold(
      appBar: AppBar(title: Text("Doctors")),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('Users')
              .where(
                "Doctor",
                isEqualTo: true,
              )
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              print("Loading");
              return Text("Loading");
            }
            var userDocument = snapshot;

            this.data = (userDocument.data.documents.map((useData) {
           
              return DoctorUserModel(
                doctorDocumentId: useData.documentID,
                age: useData["Age"],
                experience: useData["Experience"],
                firstname: useData["First name"],
                lastName: useData["Last Name"],
                uID: useData["UID"],
                hospital: useData["Hospital"],
                city: useData["city"],
                phoneNo: useData["phone"],
                specialization: useData["specialization"],
              );
            })).toList();

            return SingleChildScrollView(
              child: Column(
                children: data.map((foo) {
                  print(this.userid+"i am frm seeDocootr");
                  return ShareCard(
                    useModel: foo,
                    userId: this.userid,
                  );
                }).toList(),
              ),
            );
          }),
    );
  }
}
