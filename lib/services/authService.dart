import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  String verificationCode;
  String verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

   loginWithEmailAndPassword(String email, String pass) async {
    try {
    await  _auth.signInWithEmailAndPassword(email: email, password: pass);
      return "0";
    } catch (e) {
      print("therer was eroor whike login");
      print(e.message);
      return(e.message);
    }
  }

  registerWithEmailAndPassword(String email, String pass) async {
    try {
      AuthResult user = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      try {
        user.user.sendEmailVerification();
        return "0";
      } catch (e) {
        print(
            "An error occured while trying to send email        verification");
        print(e);
      }
    } catch (e) {
      print("error while register");
      print(e);
      return (e.message);
    }
  }

  loginWithPhoneNumber(String phoneNum, BuildContext context) {
    try {
      final PhoneCodeAutoRetrievalTimeout autoRetrive = (String verId) {
        this.verificationId = verId;
        print(this.verificationCode + "from 1");
      };
      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
        print(this.verificationId + " from 2");
      };

      /// will get an AuthCredential object that will help with logging into Firebase.
      _verificationComplete(AuthCredential authCredential) {
        print("verfication completed");
        // Navigator.of(context).pushReplacementNamed('/wrapper');
        FirebaseAuth.instance
            .signInWithCredential(authCredential)
            .then((authResult) {
          print("authResukt");

          print(authResult);
        });
      }

      // PhoneAuthProvider.getCredential(
      //     verificationId: this.verificationCode, smsCode: "123456");

      _auth.verifyPhoneNumber(
        phoneNumber: "+91" + phoneNum,
        codeAutoRetrievalTimeout: autoRetrive,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: _verificationComplete,
        verificationFailed: (e) {
          // Navigator.of(context).pushReplacementNamed('/wrapper');
          print(e);
        },
      );

      // FirebaseUser user  = result.user;
      // await DataBaseService(uid:user.uid).updateUserData('0', 'new crew member', 100);
      // return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  verifyWithCode(String code, BuildContext context) async {
// final AuthCredential credential = PhoneAuthProvider.getCredential(
//       verificationId: verificationId,
//       smsCode: code,
//     );
//     final FirebaseUser user =  await _auth.signInWithCredential(credential);
//     final FirebaseUser currentUser = await _auth.currentUser();
//     assert(user.uid == currentUser.uid);

    // print(this.verificationCode);
    print(code);
    print("verificationid");
    print(this.verificationId);
    AuthCredential credential1 = PhoneAuthProvider.getCredential(
        verificationId: this.verificationId, smsCode: code);
    print("i am auth");
    print(credential1);
    try {
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential1)).user;
      print(user.uid + "Uid");
    } catch (e) {
      print(e);
    }
    // _auth.signInWithPhoneNumber();
    // final FirebaseUser user = await _auth.sign();
    //   FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.getCredential(
    //         verificationId: this.verificationCode, smsCode: "123456")).then((user){
    //           print(user);
    //           Navigator.of(context).pushReplacementNamed('/Home');

    //         }).catchError((e){
    //           print(e);
    //         });
    // }
    // final FirebaseUser user1 = await FirebaseAuth.instance.signInWithCredential(credential);
    // final FirebaseUser currentUser = await _auth.currentUser();
    // print(currentUser);
  }

  // logout
  Future signOut(BuildContext context) async {
    try {
      return await _auth.signOut().then((user) {
        print("Sucess");
        Navigator.of(context).pushReplacementNamed('/wrapper');
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
