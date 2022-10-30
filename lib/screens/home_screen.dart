// ignore_for_file: prefer_const_constructors

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/constants/vars.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/seaech_screen.dart';
import 'package:news_app/services/news_api.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:news_app/widgets/empty_widget.dart';
import 'package:news_app/widgets/loading_widget.dart';
import 'package:news_app/widgets/tabs_widget.dart';
import 'package:news_app/widgets/top_trending_widget.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  String sortBy = SortByEnum.publishedAt.name;
  var newsType = NewsType.allNews;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context: context).getScrrenSize;
    final Color color = Utils(context: context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'News app',
            style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: SearchScreen(),
                    type: PageTransitionType.rightToLeft,
                    // inheritTheme: true
                  ),
                );
              },
              icon: const Icon(IconlyLight.search),
            ),
          ],
        ),
        drawer: DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  TabsWidget(
                    text: 'All news',
                    color: newsType == NewsType.allNews
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    function: () {
                      if (newsType == NewsType.allNews) {
                        return;
                      }
                      setState(() {
                        newsType = NewsType.allNews;
                      });
                    },
                    fontSize: newsType == NewsType.allNews ? 22 : 14,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  TabsWidget(
                    text: 'Top Trending',
                    color: newsType == NewsType.topTrending
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    function: () {
                      if (newsType == NewsType.topTrending) {
                        return;
                      }
                      setState(() {
                        newsType = NewsType.topTrending;
                      });
                    },
                    fontSize: newsType == NewsType.topTrending ? 22 : 14,
                  ),
                ],
              ),
              VerticalSpacing(10),
              newsType == NewsType.topTrending
                  ? Container()
                  : SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          paginationButton(
                              text: 'prev',
                              function: () {
                                if (currentPageIndex == 0) {
                                  return;
                                }
                                setState(() {
                                  currentPageIndex -= 1;
                                });
                              }),
                          Flexible(
                            flex: 2,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    color: currentPageIndex == index
                                        ? Colors.blue
                                        : Theme.of(context).cardColor,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentPageIndex = index;
                                        });
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('${index + 1}'),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          paginationButton(
                            text: 'Next',
                            function: () {
                              if (currentPageIndex == 5) {
                                return;
                              }
                              setState(() {
                                currentPageIndex += 1;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
              VerticalSpacing(10),
              newsType == NewsType.topTrending
                  ? Container()
                  : Align(
                      alignment: Alignment.topRight,
                      child: Material(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton(
                              value: sortBy,
                              items: dropDowmItems,
                              onChanged: (String? value) {
                                setState(() {
                                  sortBy = value!;
                                });
                              }),
                        ),
                      ),
                    ),
              FutureBuilder<List<NewsModel>>(
                future: newsType == NewsType.allNews
                    ? newsProvider.fetcAllNews(
                        pageIndex: currentPageIndex + 1, sortBy: sortBy)
                    : newsProvider.fetchTopHeadLinesNews(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return newsType == NewsType.allNews
                        ? LoadingWidget(
                            newsType: newsType,
                          )
                        : Expanded(
                            child: LoadingWidget(
                              newsType: newsType,
                            ),
                          );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: EmptyWidget(
                          text: "An error occured ${snapshot.error}",
                          imagePath: "assets/images/no_news.png"),
                    );
                  } else if (snapshot.data == null) {
                    return Expanded(
                      child: EmptyWidget(
                          text: "No news result",
                          imagePath: "assets/images/no_news.png"),
                    );
                  }
                  return newsType == NewsType.allNews
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ChangeNotifierProvider.value(
                                value: snapshot.data![index],
                                child: ArticleWidget(
                                    // title: snapshot.data![index].title,
                                    // imageUrl: snapshot.data![index].urlToImage,
                                    // readingTime:
                                    //     snapshot.data![index].readingTimeText,
                                    // dateToShow: snapshot.data![index].dateToShow,
                                    // url: snapshot.data![index].url,
                                    ),
                              );
                            },
                          ),
                        )
                      : SizedBox(
                          height: size.height * 0.6,
                          child: Swiper(
                            autoplayDelay: 8000,
                            autoplay: true,
                            itemWidth: size.width * 0.9,
                            layout: SwiperLayout.STACK,
                            viewportFraction: 0.9,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ChangeNotifierProvider.value(
                                value:snapshot.data![index] ,
                                child: TopTrendigWidget(
                                  
                                ),
                              );
                            },
                          ),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropDowmItems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByEnum.relevancy.name,
        child: Text(SortByEnum.relevancy.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text(SortByEnum.popularity.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.publishedAt.name,
        child: Text(SortByEnum.publishedAt.name),
      ),
    ];
    return menuItem;
  }

  Widget paginationButton({required String text, required Function function}) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        padding: EdgeInsets.all(6),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


//  if (newsType == NewsType.allNews)
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: newsList.length,
//                     itemBuilder: (context, index) {
//                       return ArticleWidget(imageUrl: newsList[index].urlToImage,);
//                     },
//                   ),
//                 ),
//               if (newsType == NewsType.topTrending)
//                 SizedBox(
//                   height: size.height * 0.6,
//                   child: Swiper(
//                     autoplayDelay: 8000,
//                     autoplay: true,
//                     itemWidth: size.width * 0.9,
//                     layout: SwiperLayout.STACK,
//                     viewportFraction: 0.9,
//                     itemCount: 5,
//                     itemBuilder: (context, index) {
//                       return TopTrendigWidget();
//                     },
//                   ),
//                   /* LoadingWidget(newsType: newsType,),  */
//                 ),








/* Flexible(
                            flex: 2,
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    color: currentPageIndex == index
                                        ? Colors.blue
                                        : Theme.of(context).cardColor,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentPageIndex=index;
                                        });
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${index + 1}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ), */