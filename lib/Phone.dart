import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'otpphone.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {

  sendotp() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91 ${num.text}',

          //for automatic fill otp verifaction
          verificationCompleted: (phoneAuthCredential) {

          },

          // wrong phone no. error
          verificationFailed: (error) {
            Get.snackbar("ver", error.code);
          },

          // trigger when otp sent
          codeSent: (verificationId, forceResendingToken) {
            Get.to(Otpphone(verificationId:verificationId));
          },

          // when otp expire
          codeAutoRetrievalTimeout: (verificationId) {

          },);
    }on FirebaseAuthException catch(e){
      Get.snackbar("Firebase Error", e.code);
    }
    catch(e){
      Get.snackbar("Error", e.toString());
    }
  }


  TextEditingController num = TextEditingController();

  inputfield() {
    return TextField(
      controller: num,
      decoration: InputDecoration(
          hintText: "Enter Phone Number",
          contentPadding: EdgeInsets.all(10),
          icon: Icon(Icons.phone)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Login"),),
      body: Column(
        children: [
          inputfield(),
          ElevatedButton(onPressed: () => sendotp(), child: Text("Send OTP"))
        ],
      ),
    );
  }
}
