import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/forgot.dart';
import 'package:login/signUp.dart';

import 'Phone.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;



  googlesign() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }


  signin() async {

    setState(() {
      isLoading= true;
    });
    print("isLoading11  $isLoading");
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    }on FirebaseAuthException catch(e){
      Get.snackbar("Firebase error", e.code);
    }catch(e){
      Get.snackbar("Flutter eroor", e.toString());
    }
    print("isLoading12  $isLoading");

    setState(() {
      isLoading= false;
    });
    print("isLoading13  $isLoading");

  }


  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator()) : Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Column(
        children: [
          TextField(
            controller: email,
            decoration: InputDecoration(
              hintText: "Enter Text"
            ),
          ),
          TextField(
            controller: password,
            decoration: InputDecoration(
              hintText: "Enter Pass"
            ),
          ),
          ElevatedButton(onPressed: () => signin(), child: Text("Login")),
          ElevatedButton(onPressed: () => Get.to(Signup()), child: Text("Signup")),
          ElevatedButton(onPressed: () => Get.to(Forgot()), child: Text("Reset")),
          ElevatedButton(onPressed: () =>  Get.to(Phone()), child: Text("Phone login"))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        googlesign();
      },
      child: Icon(Icons.screen_lock_landscape),),
    );
  }
}
