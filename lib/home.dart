import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/FireBase/Login.dart';


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.blue,
          statusBarBrightness: Brightness.light,
        ),
        title: Text("All News"),
        actions: [
          PopupMenuButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 5,
              itemBuilder: (context) => [
                    PopupMenuItem(
                        child: Text("Logout"),
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  title: Text("Log out"),
                                  content: Text("Are you sure ? "),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancle"),
                                      onPressed: () {
                                        Navigator.pop(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => home()));
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        _auth.signOut();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()),
                                            (route) => false);
                                      },
                                    ),
                                  ],
                                ))),
                    const PopupMenuItem(
                      child: Text("Dark Mood"),
                    ),
                    PopupMenuItem(child: Text("About Us")),
                  ])
        ],
      ),
      body:  ,
    );
  }
}
