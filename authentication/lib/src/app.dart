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
                  Tab(icon: Icon(Icons.person_add)),
                  Tab(icon: Icon(Icons.person))
                ]),
            title: const Text("Firebase Auth"),
          ),
          body: const TabBarView(
              children: [
                AuthProvidersTable(),
                Icon(Icons.person)
              ]),
        ),
      ),
    );
  }


  // Previous loading system
  /*Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/': (context) => const HomePage(),
      },
    );
  }*/
}
