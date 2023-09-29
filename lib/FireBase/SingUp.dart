import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/FireBase/FireToast.dart';
import 'package:news_app/FireBase/Login.dart';
import 'package:news_app/home.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool processWhenSignClick = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passWord = TextEditingController();

  Future<void> signUpInFirebaseByMe(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => home()), (route) => false);
    } catch (e) {
      FirebaseToast().showToast(e.toString());
    }

    setState(() {
      processWhenSignClick = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: height * .8,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("lib/assets/Icon_image/newspaper.png",
                  height: height * .3,
                  width: width * .6,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Form(
                key: _formKey,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter your email",
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: "Email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                        },
                        onFieldSubmitted: (value) {},
                        autocorrect: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        controller: _passWord,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter your PassWord",
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: Icon(Icons.remove_red_eye),
                            labelText: "PassWord"),
                        onEditingComplete: () {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter PassWord';
                          }
                        },
                        autocorrect: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        child: processWhenSignClick
                            ? const SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator())
                            : Text("Sign Up"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(_email.text.toString());
                            print(_passWord.text.toString());
                            setState(() {
                              processWhenSignClick = true;
                            });

                            signUpInFirebaseByMe(_email.text.toString(),
                                _passWord.text.toString());
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an Account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                        CupertinoButton(
                            child: Text("Log In"),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}