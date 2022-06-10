import 'package:authentication/src/facebook_auth.dart';
import 'package:authentication/src/google_auth.dart';
import 'package:authentication/src/apple_auth.dart';
import 'package:authentication/src/twitter_auth.dart';
import 'package:authentication/src/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authentication/src/anonymous.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class AuthProvidersTable extends StatefulWidget {
  const AuthProvidersTable({Key? key}) : super(key: key);

  @override
  State<AuthProvidersTable> createState() => _AuthProvidersTableState();
}

class _AuthProvidersTableState extends State<AuthProvidersTable> {
  User? _user;

  @override
  void initState() {
    // Detect when a user signs in (or out, when sign out is implemented)
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _user = FirebaseAuth.instance.currentUser!;
        });
      } else {
        setState(() {
          _user = null;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ListTile(
          title: Text('Email/Password'),
          leading: Icon(Icons.person),
          onTap: () {
            if (_user == null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              final scaffold = ScaffoldMessenger.of(context);
              scaffold.showSnackBar(
                const SnackBar(
                  content: Text('There is a user currently logged in'),
                ),
              );
            }
          },
        ),
        const ListTile(title: Text('Passwordless'), leading: Icon(Icons.key)),
        const GoogleAuthTile(),
        const FacebookAuthTile(),
        const AppleAuthTile(),
        const TwitterAuthTile(),
        const AnonymousAuthTile(),
      ],
    );
  }
}
