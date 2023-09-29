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
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 25, 12, 0),
              child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () {
                    print(searchController.text.toString());
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: InputDecoration(
                      hintText: "Search for news",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      prefixIcon: InkWell(
                        child: Icon(Icons.search),
                        onTap: () {
                          print(searchController.text.toString());
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                // color: Colors.black45,
                height: height * .038,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 15,
                    itemBuilder: (context, input) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          child:
                              Center(child: Text("lets go"), widthFactor: 1.8),
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                // color: Colors.black45,
                height: height * .135,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 15,
                    itemBuilder: (context, input) {
                      return InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.low,
                                  "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black45,
                                ),
                                width: width,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "News Heading",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("News Description",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    width: width * .5,
                    height: height * .05,
                    // color: Colors.lightBlue,
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Any News Heading",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )),
                Container(
                    width: width * .5,
                    height: height * .05,
                    // color: Colors.lightBlue,
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("More")),
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 100,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                "https://static.vecteezy.com/system/resources/thumbnails/006/299/370/original/world-breaking-news-digital-earth-hud-rotating-globe-rotating-free-video.jpg")),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            // alignment: Alignment.topLeft,
                            width: width * .98,
                            height: height * .05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black38),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "News Head",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Descption",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ]),
                            ),
                          ),
                        )
                      ]),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
