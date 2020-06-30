import 'package:flutter/material.dart';
import 'package:getit/screens/auth/auth.dart';
import 'package:getit/services/authService.dart';

class RegisterFromAuth extends StatefulWidget {
  @override
  _RegisterFromAuthState createState() => _RegisterFromAuthState();
}

class _RegisterFromAuthState extends State<RegisterFromAuth> {
  AuthService userauthservice = AuthService();
  final _formkey15 = GlobalKey<FormState>();
  String phoneNum = "";
  String sendOtp = "";
  bool checkOtp = true;
  String pass = "";
  String confromPAss = "";
  String displayErr = "";
  bool _showPassword = false;

  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  final _formkey101 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
          // key: _formkey,
          key: _formkey101,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: this.phoneNum,
                // decoration:  textInputDecarator.copyWith(hintText: "Password"),
                decoration: InputDecoration(
                  hintText: "Email",
                  // prefixText: "" ",
                ),
                // obscureText: true,
                // keyboardType: TextInputType.number,

                validator: (val) => val.length >= 10 ? null : "Enter Email",
                onChanged: (val) {
                  this.phoneNum = val;

                  // setState(() {
                  //   // this.password = val;
                  // });
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                initialValue: this.pass,
                // decoration:  textInputDecarator.copyWith(hintText: "Password"),

                decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: this._showPassword ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          setState(
                              () => this._showPassword = !this._showPassword);
                        })

                    // prefixText: "" ",
                    ),
                // obscureText: true,
                // keyboardType: TextInputType.,
                obscureText: !_showPassword,

                validator: (val) {
                  if (val.length <= 7) {
                    return ("Password length should be greater than 8");
                  }
                  if (!validateStructure(val)) {
                    return ("Password should contains atleast one charater and number");
                  }
                  // validateStructure(val) ;

                  return (null);
                  //  "Enter Password and",
                },
                onChanged: (val) {
                  this.pass = val;

                  // setState(() {
                  //   // this.password = val;
                  // });
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                initialValue: this.confromPAss,
                // decoration:  textInputDecarator.copyWith(hintText: "Password"),
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  // prefixText: "" ",
                ),
                // obscureText: true,
                // keyboardType: TextInputType.,
                obscureText: true,

                validator: (val) =>
                    val == this.pass ? null : "Password DoesNot match",
                onChanged: (val) {
                  // this.paconfromPAssss = val;

                  // setState(() {
                  //   // this.password = val;
                  // });
                },
              ),

              SizedBox(height: 3),
              Text(
                this.displayErr,
                style: TextStyle(color: Colors.redAccent),
              ),
              SizedBox(height: 3),
              RaisedButton(
                child: Text("Sign IN"),
                onPressed: () async {
                  print(this.phoneNum + this.pass);
                  print(_formkey101.currentState.validate());
                  if (_formkey101.currentState.validate()) {
                    print("i am here reg");
                    try {
                      String result = await AuthService()
                          .registerWithEmailAndPassword(
                              this.phoneNum, this.pass);
                      if (result.length > 2) {
                        this.setState(() {
                          this.displayErr = result;
                        });
                      }
                    } catch (e) {
                      print("i am errror code");
                      print(e);
                      print(e.message);
                    }
                  }

                  setState(() {
                    // this.checkOtp = !checkOtp;
                    // if (_formkey1.currentState.validate()) {

                    //   userauthservice.verifyWithCode(
                    //       this.sendOtp, context);
                    //   //     setState(() {
                    //   //   this.checkOtp = !checkOtp;

                    //   // });
                    //   print("Sign IN");
                    // }
                  });
                },
              ),

              // RaisedButton(onPressed: (){
              //   super.setState(() {

              //   });
              // })
            ],
          )),
    );
  }
}
