import 'package:flutter/material.dart';
import 'package:getit/screens/AsignToken/assignToken.dart';
import 'package:getit/screens/Home/myAppotiments.dart';
import 'package:getit/screens/Registration/registrationOfUser.dart';
import 'package:getit/screens/contact/contact.dart';
import 'package:getit/screens/editprofile/EditProfile.dart';
import 'package:getit/screens/livetoken/LiveToken.dart';
import 'package:getit/screens/refund/mainRefundPage.dart';
import 'package:getit/services/authService.dart';

class ShowDrawer extends StatelessWidget {
  String userId;

  ShowDrawer({this.userId});

  @override
  Widget build(BuildContext context) {
    print(this.userId + "iama from show drawer");
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Welcome Doctor'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Home Page'),
          onTap: () {
            Navigator.of(context).pop();
            // Update the state of the app.
            // ...
          },
        ),
          ListTile(
          title: Text('Assign Tokens'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignToken(userId: userId),
                // settings: RouteSettings(
                //   arguments: [catgary[index],this.userid],
                // ),
              ),
            );
            // Update the state of the app.
            // ...
          },
        ),
     
        ListTile(
          title: Text('Live Token'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LiveToken(userId: userId),
                // settings: RouteSettings(
                //   arguments: [catgary[index],this.userid],
                // ),
              ),
            );
            // Update the state of the app.
            // ...
          },
        ),
           ListTile(
          title: Text('Your Appointments'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyAppotiments(
                  userId: userId,
                ),
                // settings: RouteSettings(
                //   arguments: [catgary[index],this.userid],
                // ),
              ),
            );
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Refunds'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainRefundPage(doctorId: userId),
                // settings: RouteSettings(
                //   arguments: [catgary[index],this.userid],
                // ),
              ),
            );
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Edit Profile'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfile(
                  userid: this.userId,
                ),
                // settings: RouteSettings(
                //   arguments: [catgary[index],this.userid],
                // ),
              ),
            );
            // Update the state of the app.
            // ...
          },
        ),

         ListTile(
          title: Text('Contact Us'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactUser(
                  
                ),
                // settings: RouteSettings(
                //   arguments: [catgary[index],this.userid],
                // ),
              ),
            );
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Logout'),
          onTap: () {
            AuthService()
                .signOut(context)
                .then((onValue) {})
                .catchError((onError) {});

            // Update the state of the app.
            // ...
          },
        ),
      ],
    ));
  }
}
