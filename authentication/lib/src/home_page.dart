import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;

  @override
  void initState() {
    // Detect when a user signs in (or out, when sign out is implemented)
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _user = FirebaseAuth.instance.currentUser!;
        });
      }
    });
    super.initState();
  }

  Future<void> _signOut() async {
    log("Signing Out");
    _user = null;
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _user != null
            ? Text('Welcome ${_user?.displayName}')
            : const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('New application incoming....'),
            RaisedButton(
              onPressed: () async {
                await _signOut();
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
