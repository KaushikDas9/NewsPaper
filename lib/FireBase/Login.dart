import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/FireBase/FireToast.dart';
import 'package:news_app/FireBase/SingUp.dart';
import 'package:news_app/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = true;
  bool processWhenSignClick = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passWord = TextEditingController();

  Future<void> logInInFirebaseByMe(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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
          color: Colors.blueGrey.shade300,
          height: height,
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
              Padding(padding: EdgeInsets.only(bottom: 10, top: 10)),
              Form(
                key: _formKey,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        onTapOutside: (PointerDownEvent) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        style: TextStyle(
                            color: Colors.black.withOpacity(.7),
                            fontWeight: FontWeight.bold),
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
                        onTapOutside: (PointerDownEvent) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: _passWord,
                        obscureText: showPassword,
                        style: TextStyle(
                            color: Colors.black.withOpacity(.7),
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter your PassWord",
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: showPassword
                                    ? Icon(Icons.remove_red_eye_outlined)
                                    : Icon(Icons.remove_red_eye)),
                            labelText: "PassWord"),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              processWhenSignClick = true;
                            });

                            logInInFirebaseByMe(_email.text.toString(),
                                _passWord.text.toString());
                            // FocusScope.of(context).requestFocus(FocusNode());
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
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
                            : Text("Log In"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("press");
                            setState(() {
                              processWhenSignClick = true;
                            });

                            logInInFirebaseByMe(_email.text.toString(),
                                _passWord.text.toString());
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an Account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                        CupertinoButton(
                            child: Text("Sing Up"),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const signUp()),
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
