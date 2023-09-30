import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:news_app/FireBase/Login.dart';
import 'package:news_app/Model/NewsApi.dart';
import 'package:news_app/WebViewPageDesign.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<newsModel> articlesList = [];
  List<newsModel> articlesHeadindList = [];
  List<String> articlesCategoryList = [];

  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController searchController = TextEditingController();

  Future<void> getArticles(String contentType) async {
    articlesList.clear();
    String api_key = "4b25b6f7358a4e1c9f88f5434066ec51";
    var reponse = await get(Uri.parse(
        "https://newsapi.org/v2/everything?q=$contentType&from=2023-08-30&sortBy=publishedAt&apiKey=$api_key"));
    var body = json.decode(reponse.body);

    // Putting in list
    body["articles"].forEach((element) {
      newsModel model = newsModel();
      articlesList.add(newsModel.fromMap(element));
    });

    for (var i in articlesList) {
      print(i.title.toString());
    }
    setState(() {});
  }

  Future<void> getHeadindArticles() async {
    articlesHeadindList.clear();
    String api_key = "4b25b6f7358a4e1c9f88f5434066ec51";
    var reponse = await get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=$api_key"));
    var body = json.decode(reponse.body);

    // Putting in list
    body["articles"].forEach((element) {
      newsModel model = newsModel();
      articlesHeadindList.add(newsModel.fromMap(element));
    });
    for (var i in articlesHeadindList) {
      print(i.title.toString());
    }
    setState(() {});
  }

  Future<void> getArticlesCategory() async {
    articlesCategoryList.clear();
    String api_key = "4b25b6f7358a4e1c9f88f5434066ec51";
    var reponse = await get(Uri.parse(
        "https://newsapi.org/v2/top-headlines/sources?apiKey=$api_key"));
    var body = json.decode(reponse.body);

    // Putting in list
    body["sources"].forEach((element) {
      newsModel model = newsModel();
      if (!articlesCategoryList.contains(element["category"].toString()))
        articlesCategoryList.add(element["category"].toString());
    });
    for (var i in articlesCategoryList) {
      print("cate:");
      print(i.toString());
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHeadindArticles();
    getArticlesCategory();
  }

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
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    getArticles(searchController.text.toString());
                  },
                  decoration: InputDecoration(
                      hintText: "Search for news",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      prefixIcon: InkWell(
                        child: Icon(Icons.search),
                        onTap: () {
                          getArticles(searchController.text.toString());
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                // color: Colors.black45,
                height: height * .040,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articlesCategoryList.length,
                    itemBuilder: (context, input) {
                      return InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context,"/webViewPage",arguments:  );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              widthFactor: 1.5,
                              child: Text(
                                  articlesCategoryList[input]
                                      .toString()
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900))),
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    width: width,
                    height: height * .05,
                    // color: Colors.lightBlue,
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Breaking News",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    )),
                // Container(
                //     width: width * .3,
                //     height: height * .05,
                //     // color: Colors.lightBlue,
                //     alignment: AlignmentDirectional.centerEnd,
                //     child: Padding(
                //       padding: const EdgeInsets.only(right: 15),
                //       child:
                //           ElevatedButton(onPressed: () {}, child: Text("More")),
                //     ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                // color: Colors.black45,
                height: height * .135,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articlesHeadindList.length,
                    itemBuilder: (context, input) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => webViewPage(
                                      articlesHeadindList[input]
                                          .url
                                          .toString())));
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                articlesHeadindList[input]
                                    .urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,
                              ),
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
                    width: width,
                    height: height * .15,
                    // color: Colors.lightBlue,
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        maxLines: 2,
                        "LATEST NEWS ABOUT ${searchController.text.toUpperCase()}",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    )),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: articlesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => webViewPage(
                                  articlesList[index].url.toString())));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                articlesList[index].urlToImage.toString())),
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
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: width * .98,
                                child: Text(
                                  maxLines: 2,
                                  articlesList[index].description.toString(),
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
