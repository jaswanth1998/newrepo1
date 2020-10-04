import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataBaseServices {
  String getCatgary;
  DataBaseServices({this.getCatgary});
  final CollectionReference doctorsRference =
      Firestore.instance.collection("Users");
  final CollectionReference appointementRefrence =
      Firestore.instance.collection("Appotiments");


  final CollectionReference liveTokenRefrence =
      Firestore.instance.collection("LiveToken");      

  //Brew list from sanpshot
  _brewListFormQuesrySanpshot(QuerySnapshot snapshot) {
    snapshot.documents.map((doc) {
      print(doc.data["Age"]);
    }).toList();
    //  return  snapshot.documents.map((doc) {
    //     print(doc.data);
    //     return doc.data;
    //     // (Brew(
    //     //     name: doc.data["name"] ?? "",
    //     //     strength: doc.data["strength"] ?? 0,
    //     //     sugars: doc.data['Sugars'] ?? "0"
    //     //  ) );
    //   }).toList();
  }

  // Stream<List<QuerySnapshot>> get brews {
  // //  brewRefrence.snapshots().map(_brewListFormQuesrySanpshot).forEach((action){
  // //    print("object");
  // //     print(action);
  // //   });
  //   return doctorsRference.snapshots().map(_brewListFormQuesrySanpshot);
  // }
  bool getData() {
    print("I am here");
    doctorsRference.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
      return true;
    });
  }

  Future registerUser(
      String uId,
      String firstName,
      String lastName,
      int exprenice,
      int age,
      String gender,
      String specilizationDropdownValue,
      String phoneNum,
      String city,
      String hospitalName,
      String notificationToken,
      String qualificition,
      int doctorFee) async {
    return await doctorsRference.document(uId).setData({
      "UID": uId,
      "Doctor": true,
      "Experience": exprenice,
      "First name": firstName,
      "Last Name": lastName,
      "Age": age,
      "gender": gender,
      "city": city,
      "Hospital": hospitalName,
      "phone": phoneNum,
      "specialization": specilizationDropdownValue,
      "Notification Token":notificationToken,
      "Qualificition":qualificition,
      "leave":false,
      "doctorFee":doctorFee
      // ""
    });
  }

  Future transactionOfAppotiment(
      String getDoctorUid,
      String patientUid,
      String txnId,
      String resCode,
      String txnRef,
      String status,
      String approvalRef) async {
    print("iam in transtion state");
    return await appointementRefrence.add({
      "Doctor User ID": getDoctorUid,
      "Patent Uid": patientUid,
      "txnId": txnId,
      "resCode": resCode,
      "txnRef": txnRef,
      "status": status,
      "approvalRef": approvalRef,
      "CompletedAt": FieldValue.serverTimestamp(),
    });
  }

  Future appotiment(
      String testing, String getDoctorUid, String patientUid) async {
    return await appointementRefrence.add({
      "Testing": testing,
      "patient Uid": patientUid,
      "Doctor User ID": getDoctorUid,
      "startedAt": FieldValue.serverTimestamp(),
    });
  }

  Future updateToken(int tokenNum, String docid) async {
    return await appointementRefrence.document(docid).updateData({
      "token": tokenNum,
    });
  }
Future createliveTokenDB(String docUid) async{
    return await liveTokenRefrence.document(docUid).setData({
      "Token":0,
      "Uid":docUid
    });
  }

  Future<int> checkLiveTokenDB(String uID) async{
    

     return  liveTokenRefrence.document(uID).get().then((DocumentSnapshot snapshot) {
       
      // snapshot.documents.forEach((f) => print('${f.data}}'));
      // return snapshot.exists;
      if(snapshot.exists){
        return snapshot.data['Token'];
      }else{
        
        return -1;
      }
    });
  }

  Future refundTheMoney(String patientId) async{
    return await appointementRefrence.document(patientId).updateData(
      {
        "refund":true,
        "refunded":false
      }
    );

  }

 Future refundedTheMoney(String patientId) async{
    return await appointementRefrence.document(patientId).updateData(
      {
        "refunded":true
      }
    );

  }

  Future liveToken(String docUid,int tokNumber) async{
    return await liveTokenRefrence.document(docUid).updateData({
      "Token":tokNumber
    });
  }

  Future updateDoctorLeaveStatus(String docUid,bool leaveStatus)async{
    return await doctorsRference.document(docUid).updateData({
      "leave":leaveStatus
    });
  }
}
