import 'package:flutter/material.dart';
import 'package:getit/models/doctorUserModel.dart';
import 'package:getit/screens/ShareWidget/shareBottomSheet.dart';

class ShareCard extends StatelessWidget {
  DoctorUserModel useModel;
  String userId;

  ShareCard({this.useModel,this.userId});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(17),
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: 150,
                  child: Center(
                     child: Image.asset('assests/splash.gif')
                    //  Image(image: AssetImage("assests/cardDoctor.svg"))
                  )),
              Container(
                  width: double.infinity,
                  height:100,
                  child: Text("\nName "+useModel.firstname +"\n\n"+
                      
                      "Hospital Name: "+useModel.hospital+"\n\n",
                      style: TextStyle(
                        fontSize:17
                      ),
                      textAlign: TextAlign.center,
                      )),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         RaisedButton(
                           
                           child: Text("View profile  ",
                           textAlign: TextAlign.center,),
                           color: Colors.blueAccent,
                           onPressed: (){

                         }),
                         SizedBox(
                           width:20
                         
                         ),
                          RaisedButton(
                           child: Text("Book Apotiment"),
                           color: Colors.blueAccent,
                           onPressed: (){
                             print(this.userId + " iam from sharecard");
                            ShareBottomSheet(


                              context: context
                            ).settingModalBottomSheet(context,useModel.doctorDocumentId,this.userId);
                         }),
                       ],
                     )
            ],

          ),
        ),
      ),
    );
  }
}
