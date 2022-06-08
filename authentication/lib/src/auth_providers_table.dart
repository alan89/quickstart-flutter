import 'package:flutter/material.dart';
import 'dart:developer';
import 'login_page.dart';

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
    return  ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget> [
        ListTile(
          title: Text('Email/Password'),
          leading: Icon(Icons.person),
          onTap: () {
              log("Nav to a new window");
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
        ),
        ListTile( title: Text('Passwordless'), leading: Icon(Icons.key))
      ],
    );
  }
}
