import 'dart:convert';

import 'package:authentication/src/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;

class CustomAuthTile extends StatelessWidget {
  const CustomAuthTile({Key? key}) : super(key: key);

  Future<UserCredential> signInWithCustomAuth() async {
    // final result = await http.get(Uri.parse(
    //     'https://us-central1-contribute-flutter-quickstart.cloudfunctions.net/createToken'));

    // final json = jsonDecode(result.body);
    print(json);
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('createToken');
    final results = await callable();
    print(results.data);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCustomToken(results.data["customToken"]);
  }

  void signIn(BuildContext context) async {
    final userCredential = await signInWithCustomAuth();
    print(userCredential.user);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Custom'),
      leading: const FaIcon(FontAwesomeIcons.certificate),
      onTap: () => signIn(context),
    );
  }
}
