import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youcan/Api/NewsApi.dart';
import 'package:youcan/Models/ArticleMode.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  NewsApi getData = NewsApi();
  List<ArticleModel> _listNews = [];
  int page = 1;
  bool loading = true;
  List<String> category = [
    "سياسة",
    "مجتمع",
    "اقتصاد",
    "رياضة",
    "علوم",
    "دراسات",
  ];

  _fetchData() {
    getData.fetchNews(page).then((value) {
      _listNews.addAll(value);
      setState(() {
        loading = false;
        page++;
      });
    });
  }

  @override
  void initState() {
    _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff6e2f8f),
                Color(0xffa2378e),
              ]),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 150, right: 20, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'images/logo.png',
                  ),
                  Icon(Icons.article_sharp, color: Colors.white),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black,
          ),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff6e2f8f),
                Color(0xffa2378e),
              ]),
            ),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        category[index],
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  );
                }),
          ),
          Flexible(
            child: loading
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(backgroundColor: Colors.grey),
                        SizedBox(width: 7),
                        Text('Loading....')
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _listNews.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(_listNews[index].title),
                          Container(
                              child: Image.network(_listNews[index].image)),
                        ],
                      );
                    }),
          )
        ],
      ),
    );
  }
}
