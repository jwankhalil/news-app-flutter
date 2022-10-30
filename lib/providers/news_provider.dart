import 'package:flutter/cupertino.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_api.dart';

class NewsProvider with ChangeNotifier{
  List<NewsModel> newsList=[];

  List<NewsModel> get getNewsList{
    return newsList;
  }

  Future<List<NewsModel>> fetcAllNews({required int pageIndex,required String sortBy})async{
    newsList =await NewsApi.getAllNews(page: pageIndex,sortBy: sortBy);
    return newsList;
  }

  Future<List<NewsModel>> fetchTopHeadLinesNews()async{
    newsList =await NewsApi.getATopLinesNews();
    return newsList;
  }
  Future<List<NewsModel>> searchNewsProvider({required String query})async{
    newsList =await NewsApi.searchNews(query: query);
    return newsList;
  }

  NewsModel findByDate({required String publishAt}){
    return newsList.firstWhere((newsModel) => newsModel.publishedAt==publishAt);
  }
}