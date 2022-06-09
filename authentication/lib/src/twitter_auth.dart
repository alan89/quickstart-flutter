import 'package:authentication/src/credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';

import 'home_page.dart';

class TwitterAuthTile extends StatelessWidget {
  const TwitterAuthTile({Key? key}) : super(key: key);

  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
        apiKey: CredentialsStrings.twitterApiKey,
        apiSecretKey: CredentialsStrings.twitterApiSecretKey,
        redirectURI: CredentialsStrings.twitterRedirectURI);

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }

  void signIn(BuildContext context) async {
    final userCredential = await signInWithTwitter();
    print(userCredential.user);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Google'),
      leading: const Icon(Icons.android),
      onTap: () => signIn(context),
    );
  }
}
