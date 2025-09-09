import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    // await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage ")),
      body: Center(child: Text("Welcome: ${user!.email}")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signout(),
        child: Icon(Icons.login_rounded),
      ),
    );
  }
}
