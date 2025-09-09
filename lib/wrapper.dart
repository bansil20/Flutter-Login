import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/homepage.dart';
import 'package:login/login.dart';
import 'package:login/verification.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("snapshot ${snapshot.data}");
            if (!snapshot.data!.emailVerified) {
              print("snapshot yessssss ");

              return Verification();
            } else {
              print("snapshot Nooooo ");

              return Homepage();
            }
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
