import 'package:flutter/material.dart';
import 'package:getit/services/database.dart';
import 'package:upi_india/upi_india.dart';

class UpiTranstionService {
  Future _transaction;
  String doctorUserID;
  String patientUid;

  UpiTranstionService({this.doctorUserID,this.patientUid});


  Future<String> initiateTransaction({String app =   UpiIndiaApps.GooglePay}) async {
    print("i am here "+ app);
    DataBaseServices().appotiment("testing",doctorUserID,patientUid);
    UpiIndia upi = new UpiIndia(
      app: app,
      receiverUpiId: 'jaswanthtata@ybl',
      receiverName: 'Jaswanth tata',
      transactionRefId: 'TestingId',
      transactionNote: '.',
      amount: 1.0,
    );

    String response = await upi.startTransaction();
    return response;
  //  UpiIndiaResponse _upiResponse;
  //                     _upiResponse = UpiIndiaResponse(snapshot.data);
  //   print( );
  }

}