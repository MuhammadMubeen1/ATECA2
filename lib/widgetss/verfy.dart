import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YourVerificationScreen extends StatefulWidget {
  @override
  _YourVerificationScreenState createState() => _YourVerificationScreenState();
}

class _YourVerificationScreenState extends State<YourVerificationScreen> {
  late Timer timer;
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    // Start the timer to check email verification status periodically
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });

    // Send email verification when screen initializes
    sendEmailVerification();
  }

  @override
  void dispose() {
    // Cancel the timer when the screen is disposed
    timer.cancel();
    super.dispose();
  }

  void sendEmailVerification() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    Fluttertoast.showToast(
      msg: 'Verification email sent. Please wait...',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      textColor: Colors.black,
    );
  }

  void checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      // Email is verified, navigate to next screen and cancel timer
      timer.cancel(); // Cancel the timer since email is verified
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => UpdatePasswordScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'A verification email has been sent to your email address.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Show a loading indicator while verifying email
          ],
        ),
      ),
    );
  }
}

class UpdatePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password Screen'),
      ),
      body: Center(
        child: Text('This is the update password screen.'),
      ),
    );
  }
}