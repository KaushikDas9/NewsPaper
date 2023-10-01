import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/FireBase/Login.dart';
import 'package:news_app/home.dart';

class Splash {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void timeContol(BuildContext context) {
    if (_auth.currentUser == null) {
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route route) => false);
      });
    } else {
      Timer(const Duration(milliseconds: 100), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const home()),
            (Route route) => false);
      });
    }
  }
}
