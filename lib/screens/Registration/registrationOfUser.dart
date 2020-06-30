import 'package:flutter/material.dart';
import 'package:getit/screens/ShareWidget/constart.dart';
import 'package:getit/screens/auth/displayFrom.dart';
import 'package:getit/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationOfUser extends StatefulWidget {
  String uid;

  RegistrationOfUser({this.uid});

  @override
  _RegistrationOfUserState createState() =>
      _RegistrationOfUserState(uid: this.uid);
}

class _RegistrationOfUserState extends State<RegistrationOfUser> {
  String uid;

  _RegistrationOfUserState({this.uid});
  String firstName = "";

  String lastName = "";

  int age;

  String gender = "Male";

  String city;

  String dropdownValue = 'Male';
  String specilizationDropdownValue = "General";
  String hospitalName = "";
  String phoneNum = "";
  int exprenice;
  String userNotificationToken = "";
  String qualificition = "";

  @override
  Widget build(BuildContext context) {
    final _formkey5 = GlobalKey<FormState>();

    Future<SharedPreferences> setData = SharedPreferences.getInstance();
    setData.then((data) => {
          this.userNotificationToken = data.getString("User Notification Token")
        });
    return 
    SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: <Widget>[
            Container(
                child: Text(
              "Registration Page",
              textAlign: TextAlign.center,
            )),
            Container(
              margin: EdgeInsets.all(20),
              child: Form(
                key: _formkey5,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: this.firstName,
                        decoration:
                            textInputDecarator.copyWith(hintText: "First Name"),
                        onChanged: (val) {
                          this.firstName = val;
                        },
                        validator: (val) =>
                            val.length <= 1 ? 'Enter First Name' : null,
                      ),
                      TextFormField(
                        initialValue: this.lastName,
                        decoration:
                            textInputDecarator.copyWith(hintText: "Last Name"),
                        onChanged: (val) {
                          this.lastName = val;
                        },
                        validator: (val) =>
                            val.length <= 1 ? 'Enter Last Name' : null,
                      ),
                      TextFormField(
                        initialValue: this.qualificition,
                        decoration: textInputDecarator.copyWith(
                            hintText: "Qualificition"),
                        onChanged: (val) {
                          this.qualificition = val;
                        },
                        validator: (val) =>
                            val.length <= 1 ? 'Enter Qualificition' : null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Gender:"),
                          SizedBox(width: 18),
                          DropdownButton<String>(
                            value: gender,
                            // icon: Icon(Icons.arrow_downward),
                            // iconSize: 24,
                            // elevation: 16,
                            // style: TextStyle(
                            //   color: Colors.deepPurple
                            // ),
                            // underline: Container(
                            //   height: 2,
                            //   color: Colors.deepPurpleAccent,
                            // ),
                            onChanged: (String newValue) {
                              setState(() {
                                this.gender = newValue;
                              });
                            },
                            items: <String>['Male', 'Female']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Specialization:"),
                          SizedBox(width: 18),
                          DropdownButton<String>(
                            value: specilizationDropdownValue,
                            // icon: Icon(Icons.arrow_downward),
                            // iconSize: 24,
                            // elevation: 16,
                            // style: TextStyle(
                            //   color: Colors.deepPurple
                            // ),
                            // underline: Container(
                            //   height: 2,
                            //   color: Colors.deepPurpleAccent,
                            // ),
                            onChanged: (String newValue) {
                              setState(() {
                                this.specilizationDropdownValue = newValue;
                              });
                            },
                            items: <String>[
                              'General',
                              "Diabetes",
                              "ENT",
                              "Nephrology",
                              "Neurology",
                              "Oncology",
                              "Pediatrician",
                              "Psychology",
                              "Cardiology",
                              "Physiology",
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      TextFormField(
                        initialValue: this.age.toString() == "null"
                            ? ""
                            : this.age.toString(),
                        decoration:
                            textInputDecarator.copyWith(hintText: "age"),
                        validator: (val) => val.length > 2 || val.length == 0
                            ? 'Enter correct age'
                            : null,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          this.age = int.parse(val);
                        },
                      ),
                      TextFormField(
                        initialValue: this.exprenice.toString() == "null"
                            ? ""
                            : this.exprenice.toString(),
                        decoration:
                            textInputDecarator.copyWith(hintText: "Experience"),
                        validator: (val) => val.length > 2 || val.length == 0
                            ? 'Enter Experience'
                            : null,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          this.exprenice = int.parse(val);
                        },
                      ),
                      TextFormField(
                        decoration:
                            textInputDecarator.copyWith(hintText: "Hospital"),
                        validator: (val) =>
                            val.length < 2 ? 'Enter the Hospital Name' : null,
                        // keyboardType: TextInputType.number,
                        onChanged: (val) {
                          this.hospitalName = val;
                        },
                      ),
                      TextFormField(
                        decoration: textInputDecarator.copyWith(
                            hintText: "Offical Phone"),
                        validator: (val) => val.length != 10
                            ? 'Enter correct phone number'
                            : null,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          this.phoneNum = val;
                        },
                      ),
                      TextFormField(
                        decoration:
                            textInputDecarator.copyWith(hintText: "City"),
                        onChanged: (val) {
                          this.city = val;
                        },
                        validator: (val) =>
                            val.length <= 1 ? 'Enter City' : null,
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                          child: Text("Submit"),
                          onPressed: () {
                            if (_formkey5.currentState.validate()) {
                              print(this.uid +
                                  this.lastName +
                                  this.age.toString() +
                                  this.gender +
                                  this.specilizationDropdownValue +
                                  this.phoneNum +
                                  this.city);

                              dynamic result = DataBaseServices().registerUser(
                                  this.uid,
                                  this.firstName,
                                  this.lastName,
                                  this.exprenice,
                                  this.age,
                                  this.gender,
                                  this.specilizationDropdownValue,
                                  this.phoneNum,
                                  this.city,
                                  this.hospitalName,
                                  this.userNotificationToken,
                                  this.qualificition);
                              print(result);
                            }
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
