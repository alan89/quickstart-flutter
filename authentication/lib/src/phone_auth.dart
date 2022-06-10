import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthTile extends StatelessWidget {
  const PhoneAuthTile({Key? key}) : super(key: key);

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
      title: const Text('Phone Auth'),
      leading: const Icon(Icons.phone),
      onTap: () {
        if(FirebaseAuth.instance.currentUser == null){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PhonePage()),
          );
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

class PhonePage extends StatelessWidget {

  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<UserCredential?> _loginWithPhoneNumber(String number, BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        } else {
          print(e.code);
          print(e.message);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        //show dialog to take input from the user
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Enter SMS Code"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _codeController,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Done"),
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    String smsCode = _codeController.text.trim();
                    PhoneAuthCredential _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                    await auth.signInWithCredential(_credential);
                    Navigator.of(context).pop();
                    final scaffold = ScaffoldMessenger.of(context);
                    scaffold.showSnackBar(
                      const SnackBar(
                        content: Text('User logged in correctly'),
                      ),
                    );
                  },
                )
              ],
            )
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Timout");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500.0),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      label: Text('Phone Number'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? input){
                      if (input == null || input.isEmpty) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await _loginWithPhoneNumber(_phoneController.text, context);
                    if (FirebaseAuth.instance.currentUser != null) {
                      Navigator.of(context).pop();
                      final scaffold = ScaffoldMessenger.of(context);
                      scaffold.showSnackBar(
                        const SnackBar(
                          content: Text('User logged in correctly'),
                        ),
                      );
                    }
                  },
                  child: Text('Login with Phone Number'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}