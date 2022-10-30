import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_consts.dart';
import 'package:news_app/constants/http_exceptions.dart';
import 'package:news_app/models/news_model.dart';

class NewsApi {
  static Future<List<NewsModel>> getAllNews({required int page,required String sortBy}) async {
    try {
      // var url = Uri.parse("https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=610a1369e3984b49947abff8a6da6c2f");
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "5",
        "domains": "techcrunch.com",
        "page": page.toString(),
        "sortBy": sortBy,

        
      });
      var response = await http.get(
        uri,
        headers: {"X-Api-key": API_KEY},
      );
      Map data = jsonDecode(response.body);
      List newTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data["articles"]) {
        newTempList.add(v);
      //  log(v.toString());
      }
      return NewsModel.newsFromSnapshot(newTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<List<NewsModel>> getATopLinesNews() async {
    try {
      // var url = Uri.parse("https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=610a1369e3984b49947abff8a6da6c2f");
      var uri = Uri.https(BASEURL, "v2/top-headlines", {
       'country':'us'
       
      });
      var response = await http.get(
        uri,
        headers: {"X-Api-key": API_KEY},
      );
      Map data = jsonDecode(response.body);
      List newTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data["articles"]) {
        newTempList.add(v);
       // log(v.toString());
      }
      return NewsModel.newsFromSnapshot(newTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<List<NewsModel>> searchNews({required String query}) async {
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": query,
        "pageSize": "10",
        "domains": "techcrunch.com",
        

        
      });
      var response = await http.get(
        uri,
        headers: {"X-Api-key": API_KEY},
      );
      Map data = jsonDecode(response.body);
      List newTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data["articles"]) {
        newTempList.add(v);
      //  log(v.toString());
      }
      return NewsModel.newsFromSnapshot(newTempList);
    } catch (error) {
      throw error.toString();
    }
  }
}
