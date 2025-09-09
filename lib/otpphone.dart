import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/wrapper.dart';
import 'package:pinput/pinput.dart';

class Otpphone extends StatefulWidget {

  final String verificationId;

  const Otpphone({super.key, required this.verificationId});

  @override
  State<Otpphone> createState() => _OtpphoneState();
}

class _OtpphoneState extends State<Otpphone> {

  var code = '';

  signin() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: code);

    try{
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) => Get.offAll(Wrapper()),);
    }on FirebaseAuthException catch(e){
      Get.snackbar("Firebase Error", e.code);
    }catch(e){
      Get.snackbar("error", e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Otp Verification"),

        ],
      ),
    );
  }

  Widget textcode() {
    return Center(
      child: Pinput(
        length: 6,
        onChanged: (value) {
          setState(() {
            code = value;
          });
        },
      ),
    );
  }


  Widget button() {
    return Center(
      child: ElevatedButton(onPressed: signin(), child: Text("Verify Otp")),
    );
  }
}
