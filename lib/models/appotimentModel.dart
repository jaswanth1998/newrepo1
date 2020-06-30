import 'package:intl/intl.dart';
class AppotimentModel {
  String testing;
  var  datenow;
  String doctorid;
  String appotimentId;
  int tokenNum;
  String patienName;
  int patientAge;
  String patienMobileNum;
  String patientGender;
  String bookedSlot;

  AppotimentModel(String testing, var datenow,{this.doctorid,this.appotimentId,this.tokenNum,this.patienName,this.patientAge,this.patienMobileNum,this.patientGender,this.bookedSlot}){
    this.testing = testing;
    print(DateTime.fromMicrosecondsSinceEpoch(datenow.microsecondsSinceEpoch).toString() + "i am type" );
    // this.datenow  = DateTime.fromMillisecondsSinceEpoch(datenow);
    //  DateFormat.yMMMd().format(new DateTime.now())

    DateTime thatDate = DateTime.fromMicrosecondsSinceEpoch(datenow.microsecondsSinceEpoch) ;
    String formattedDate = DateFormat("dd-MM-yyyy 'on Time' kk:mm").format(thatDate);
    // String formattedDate = DateFormat('dd-MM-yyyy – kk:mm').format(thatDate);
    this.datenow  = formattedDate;
  }




}