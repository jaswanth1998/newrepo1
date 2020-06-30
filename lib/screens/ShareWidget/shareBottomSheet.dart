import 'package:flutter/material.dart';
import 'package:getit/services/database.dart';
import 'package:getit/services/upiTranstionService.dart';
import 'package:upi_india/upi_india.dart';

class ShareBottomSheet {
  Future _transaction;
  int faliureCount = 0;
  int elseCount= 0 ;
  BuildContext context;
  ShareBottomSheet({this.context});
  void settingModalBottomSheet(context, String doctorUid,String userId) {
    print(userId+ "It is userid");
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            child: Text(
                              " Cancel  ",
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.redAccent,
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        SizedBox(width: 20),
                        RaisedButton(
                            child: Text("Book Apotiment"),
                            color: Colors.greenAccent,
                            onPressed: () {
                              print("i am here");
                            _transaction =   UpiTranstionService( doctorUserID: doctorUid,patientUid: userId).initiateTransaction();
                            }),
                      ],
                    ),
                    SizedBox(height: 20),
                    FutureBuilder(
                      future: _transaction,
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        
                        // DataBaseServices().transactionOfAppotiment(doctorUid,  firstName, lastName, age, gender, city)

                           if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null){
                  return Text('Waiting for result');
                      }else{switch (snapshot.data.toString()) {

                    case UpiIndiaResponseError.APP_NOT_INSTALLED:
                      return Text(
                        'App not installed.',
                      );
                      break;
                    case UpiIndiaResponseError.INVALID_PARAMETERS:
                      return Text(
                        'Requested payment is invalid.',
                      );
                      break;
                    case UpiIndiaResponseError.USER_CANCELLED:
                      return Text(
                        'It seems like you cancelled the transaction.',
                      );
                      break;
                    case UpiIndiaResponseError.NULL_RESPONSE:
                      return Text(
                        'No data received',
                      );
                      break;
                    default:
                      UpiIndiaResponse _upiResponse;
                      _upiResponse = UpiIndiaResponse(snapshot.data);
                      String txnId = _upiResponse.transactionId;
                      String resCode = _upiResponse.responseCode;
                      String txnRef = _upiResponse.transactionRefId;
                      String status = _upiResponse.status;
                      String approvalRef = _upiResponse.approvalRefNo;
                      if(status == "failure" && this.faliureCount ==0){
                       DataBaseServices().transactionOfAppotiment(doctorUid, userId , txnId, resCode, txnRef, status, approvalRef); 
                       this.faliureCount = this.faliureCount+1;
                      }else if(this.elseCount==0){
                        DataBaseServices().transactionOfAppotiment(doctorUid, userId , txnId, resCode, txnRef, status, approvalRef);
                        this.elseCount = this.elseCount+1;
                      }
                      
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Transaction Id: $txnId'),
                          Text('Response Code: $resCode'),
                          Text('Reference Id: $txnRef'),
                          Text('Status: $status'),
                          Text('Approval No: $approvalRef'),
                        ],
                      );
                      }
                      }}
                      ),
                    Column(

                    ),

                  ],
                )
              ],
            ),
          );
        });
  }
}
