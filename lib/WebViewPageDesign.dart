import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_app/FireBase/Login.dart';
import 'package:news_app/home.dart';

class webViewPage extends StatefulWidget {
  final String url;
  const webViewPage(this.url);

  @override
  State<webViewPage> createState() => _webViewPageState();
}

class _webViewPageState extends State<webViewPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  InAppWebViewController? webViewController;
  late bool isPageStarted = false;
  @override
  void initState() {
    super.initState();
    isPageStarted = true;
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
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
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    title: Text("Log out"),
                                    content: Text("Are you sure ? "),
                                    actions: [
                                      TextButton(
                                        child: Text("Cancle"),
                                        onPressed: () {
                                          Navigator.pop(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      home()));
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
        body: Stack(
          children: [
            InAppWebView(
              onPageCommitVisible: (controller, url) {
                webViewController = controller;
                setState(() {
                  isPageStarted = false;
                });
              },
              onLoadStart: (controller, url) {
                setState(() {
                  isPageStarted = true;
                });
              },
              initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Visibility(
                child: CircularProgressIndicator(),
                visible: isPageStarted,
              ),
            ),
          ],
        ));
  }
}
