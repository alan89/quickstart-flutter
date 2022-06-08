import 'package:authentication/src/facebook_auth.dart';
import 'package:authentication/src/google_auth.dart';
import 'package:authentication/src/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class AuthProvidersTable extends StatefulWidget {
  const AuthProvidersTable({Key? key}) : super(key: key);

  @override
  State<AuthProvidersTable> createState() => _AuthProvidersTableState();
}

class _AuthProvidersTableState extends State<AuthProvidersTable> {
  @override
  void initState() {
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
            log("Nav to a new window");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        const ListTile(title: Text('Passwordless'), leading: Icon(Icons.key)),
        const GoogleAuthTile(),
        const FacebookAuthTile()
      ],
    );
  }
}
