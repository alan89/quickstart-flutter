import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnonymousAuthTile extends StatelessWidget {
  const AnonymousAuthTile({Key? key}) : super(key: key);

  Future<UserCredential?> signInAnonymous() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
      return null;
    }
  }

  void signIn(BuildContext context) async {
    final userCredential = await signInAnonymous();
    print(userCredential?.user);
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Anpnymous User logged in correctly'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Anonymous'),
      leading: const Icon(Icons.person_off),
      onTap: () {
        if(FirebaseAuth.instance.currentUser == null){
          signIn(context);
        } else {
          final scaffold = ScaffoldMessenger.of(context);
          scaffold.showSnackBar(
            const SnackBar(
              content: Text('There is a currently user logged in'),
            ),
          );
        }
      },
    );
  }
}
