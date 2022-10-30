// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:page_transition/page_transition.dart';

import 'package:news_app/constants/vars.dart';
import 'package:news_app/screens/blog_details.dart';
import 'package:news_app/screens/news_details_webview.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:provider/provider.dart';

class ArticleWidget extends StatelessWidget {

// final String imageUrl ,title,url,dateToShow,readingTime;
 
  @override
  Widget build(BuildContext context) {
    final newsModelProvider =Provider.of<NewsModel>(context);
    Size size = Utils(context: context).getScrrenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, BlogDetails.routeName,arguments: newsModelProvider.publishedAt);
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                color: Theme.of(context).cardColor,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Hero(
                        tag: newsModelProvider.publishedAt,
                        child: FancyShimmerImage(
                          height: size.height * 0.12,
                          width: size.height * 0.12,
                         errorWidget: Image.asset("assets/images/empty_image.png"),
                          imageUrl:
                              newsModelProvider.urlToImage,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            //title
                            newsModelProvider.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: smallTextStyle,
                          ),
                          VerticalSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              newsModelProvider.readingTimeText,
                              style: smallTextStyle,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        child: NewsDetailsWebView(url: newsModelProvider.url,),
                                        type: PageTransitionType.rightToLeft),
                                  );
                                },
                                icon: Icon(Icons.link),
                                color: Colors.blue,
                              ),
                              FittedBox(
                                child: Text(
                                  newsModelProvider.dateToShow,
                                  maxLines: 1,
                                  style: smallTextStyle,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
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
