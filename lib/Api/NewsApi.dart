import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youcan/Models/ArticleMode.dart';

class NewsApi {
  static const String urlAllData =
      "http://soltana.ma/wp-json/wp/v2/posts?_embed";

  Future<List<ArticleModel>> fetchNews(int page) async {
    http.Response response = await http.get(
        urlAllData + '?page=' + page.toString(),
        headers: {"Accept": "application/json"});

    switch (response.statusCode) {
      case 200:
        List<ArticleModel> listProduct = [];
        var body = jsonDecode(response.body);
        for (var item in body) {
          listProduct.add(ArticleModel.fromJson(item));
        }
        return listProduct;
        break;
      case 404:
        throw Exception("Failed to load products from fake API'");
        break;
      case 301:
      case 302:
      case 303:
        throw Exception("Failed to load products from fake API");
        break;
      default:
        throw Exception("Please check your internet connection");
        break;
    }
  }
}
