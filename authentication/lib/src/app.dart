import 'package:flutter/material.dart';
import 'auth_providers_table.dart';
import 'home_page.dart';
import 'login_page.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person_add), text: "Providers"),
                  Tab(icon: Icon(Icons.person), text: "Current User")
                ]),
            title: const Text("Firebase Auth"),
          ),
          body: const TabBarView(
              children: [
                AuthProvidersTable(),
                HomePage()
              ]),
        ),
      ),
    );
  }

}
