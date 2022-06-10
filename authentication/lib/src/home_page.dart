import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;

  final TextEditingController _displayNameController = TextEditingController();

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

  Future<void> _signOut() async {
    log("Signing Out");
    _user = null;
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user != null ?
        ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            if (_user?.photoURL != null)
              const SizedBox(height: 24),
            if (_user?.photoURL != null)
              buildImage(_user?.photoURL ?? ""),
            const SizedBox(height: 24),
            buildUserInfo(_user),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                //show dialog to take input from the user
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      title: Text("Edit Photo URL"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            controller: _displayNameController,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Save"),
                          onPressed: () async {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            await auth.currentUser!.updatePhotoURL(_displayNameController.text);
                            setState((){
                              _user = FirebaseAuth.instance.currentUser!;
                            });
                            Navigator.of(context).pop();
                            final scaffold = ScaffoldMessenger.of(context);
                            scaffold.showSnackBar(
                              const SnackBar(
                                content: Text('Photo URL updated correctly'),
                              ),
                            );
                          },
                        )
                      ],
                    )
                );
              },
              child: Text('Edit Photo URL'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                await auth.currentUser!.sendEmailVerification();
                final scaffold = ScaffoldMessenger.of(context);
                scaffold.showSnackBar(
                  const SnackBar(
                    content: Text('Email sent correctly'),
                  ),
                );
              },
              child: const Text('Send Verification Email'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await _signOut();
              },
              child: Text('Log Out'),
            ),
          ],
        )
      : const Center(
        child: Text('You will see the user information in this page once you are logged in'),
      )
    );
  }


  // Widget to show an image
  Widget buildImage(String imagePath) {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.contain,
          width: 128,
          height: 128,
          //child: InkWell(onTap: ()={}),
        ),
      ),
    );
  }

  Widget buildUserInfo(User? user) => Column(
    children: [
      TextButton(
          onPressed: (){
            //show dialog to take input from the user
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: Text("Edit Display Name"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _displayNameController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Save"),
                      onPressed: () async {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        await auth.currentUser!.updateDisplayName(_displayNameController.text);
                        setState((){
                          _user = FirebaseAuth.instance.currentUser!;
                        });
                        Navigator.of(context).pop();
                        final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(
                          const SnackBar(
                            content: Text('User display name updated correctly'),
                          ),
                        );
                      },
                    )
                  ],
                )
            );
          },
          child: Text(
            user?.displayName ?? "Display name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )
      ),
      const SizedBox(height: 15),
      TextButton(
        onPressed: (){
          //show dialog to take input from the user
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text("Edit Email"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _displayNameController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Save"),
                    onPressed: () async {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.currentUser!.updateEmail(_displayNameController.text);
                      setState((){
                        _user = FirebaseAuth.instance.currentUser!;
                      });
                      Navigator.of(context).pop();
                      final scaffold = ScaffoldMessenger.of(context);
                      scaffold.showSnackBar(
                        const SnackBar(
                          content: Text('User email updated correctly'),
                        ),
                      );
                    },
                  )
                ],
              )
          );
        },
        child: Text(
          user?.email ?? "email",
          style: TextStyle(color: Colors.grey, fontSize: 20),
        )
      ),
      const SizedBox(height: 15),
      Text(
        user?.phoneNumber ?? "No phone number",
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
      const SizedBox(height: 15),
      Text(
        "UID: " + user!.uid,
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
      const SizedBox(height: 15),
      Text(
        user != null ?
        "The email is verified: " + user.emailVerified.toString() :
        "email Verification",
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
      const SizedBox(height: 15),
      Text(
        user != null ?
          "Is Anonymous: " + user.isAnonymous.toString():
          "Is Anonymous",
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
      const SizedBox(height: 15),
      Text(
        user.providerData.toString(),
        style: TextStyle(color: Colors.grey),
      ),
      const SizedBox(height: 15),
      Text(
        user.metadata.toString(),
        style: TextStyle(color: Colors.grey),
      ),
    ],
  );

}
