import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/wrapper.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {


  @override
  void initState() {
    // TODO: implement initState
    sendVerificationLink();
    super.initState();
  }


  sendVerificationLink() async {
    final user = FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification().then((value) {
      Get.snackbar("Email Link", "link is Sent",margin: EdgeInsets.all(20));
    },);
  }

  reload() async {
    await FirebaseAuth.instance.currentUser!.reload().then((value) => Get.offAll(Wrapper()),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Link senddd"),
      floatingActionButton: FloatingActionButton(onPressed: (){
        reload();
      }, child:Icon(Icons.new_releases) ),
    );
  }
}
