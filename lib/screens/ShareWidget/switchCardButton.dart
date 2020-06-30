import "package:flutter/material.dart";
import 'package:getit/services/database.dart';

class SwitchCardButton extends StatefulWidget {
  bool leaveStatus;
  String userid;
  SwitchCardButton({this.leaveStatus,this.userid});

  @override
  _SwitchCardButtonState createState() => _SwitchCardButtonState(leaveStatus: this.leaveStatus,userid:this.userid);
}

class _SwitchCardButtonState extends State<SwitchCardButton> {
  
  bool isLeave = false;
  String userid;
  bool leaveStatus;
  _SwitchCardButtonState({this.leaveStatus,this.userid});
  
  @override
  Widget build(BuildContext context) {

    
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      margin: EdgeInsets.all(10),
      child: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 5),
          Text("Your Leave Status", style: TextStyle(fontSize: 21)),
          SizedBox(height: 10),
          Switch(
              onChanged: (val) {
                this.setState(() {
                  this.leaveStatus = val;
                  this.isLeave = !this.isLeave;
                });
              },
              value: this.leaveStatus),
          Container(
            margin: EdgeInsets.all(20),
            child: ButtonTheme(
              minWidth: double.infinity,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  color: Color.fromRGBO(43, 39, 240, 1),
                  child: Text("Update Status",
                      style: TextStyle(color: Colors.white)),
                  onPressed:this.isLeave? () async{
                  
                   try{
                      dynamic data =   await DataBaseServices().updateDoctorLeaveStatus(this.userid,this.leaveStatus);
                    this.setState(() {
                  
                  this.isLeave = !this.isLeave;
                });
                   }catch(e){

                   }
                  
                   
                   
                  }:null),
            ),
          ),
        ]),
      ),
    );
  }
}
