import 'package:authentication/src/credentials.dart';
import 'package:authentication/src/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:github_sign_in/github_sign_in.dart';

class GithubAuthTile extends StatelessWidget {
  const GithubAuthTile({Key? key}) : super(key: key);

  Future<UserCredential> signInWithGitHub(BuildContext context) async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: CredentialsStrings.githubClientId,
        clientSecret: CredentialsStrings.githubClientSecret,
        redirectUrl: CredentialsStrings.githubRedirectUrl);

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(githubAuthCredential);
  }

  void signIn(BuildContext context) async {
    final userCredential = await signInWithGitHub(context);
    print(userCredential.user);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Github'),
      leading: const FaIcon(FontAwesomeIcons.github),
      onTap: () => signIn(context),
    );
  }
}
