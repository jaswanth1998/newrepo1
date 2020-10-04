import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUser extends StatefulWidget {
  @override
  _ContactUserState createState() => _ContactUserState();
}

class _ContactUserState extends State<ContactUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Contact")),
      body: Center(
        child: Column(
          children:<Widget>[
            SizedBox(height:10),
            Text("For any further queries contact us on"),
            RaisedButton(onPressed: ()=>{
              launch("tel://7989836033")
            },
            child:Text("call us"))
          ]
        ),
      ),
    );
  }
}