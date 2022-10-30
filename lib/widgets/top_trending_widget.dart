// ignore_for_file: prefer_const_constructors

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/news_model.dart';
import 'package:page_transition/page_transition.dart';

import 'package:news_app/screens/blog_details.dart';
import 'package:news_app/screens/news_details_webview.dart';
import 'package:news_app/services/utils.dart';
import 'package:provider/provider.dart';

class TopTrendigWidget extends StatelessWidget {
  const TopTrendigWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context: context).getScrrenSize;
    final Color color = Utils(context: context).getColor;
    final topNewsProvider = Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, BlogDetails.routeName,arguments: topNewsProvider.publishedAt);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    boxFit: BoxFit.fill,
                    errorWidget: Image.asset("assets/images/empty_image.png"),
                    imageUrl: topNewsProvider.urlToImage,
                    width: double.infinity,
                    height: size.height * 0.33,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  topNewsProvider.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: NewsDetailsWebView(
                              url: topNewsProvider.url,
                            ),
                            type: PageTransitionType.rightToLeft),
                      );
                    },
                    icon: Icon(Icons.link),
                  ),
                  Spacer(),
                  SelectableText(
                    topNewsProvider.dateToShow,
                    style: GoogleFonts.montserrat(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
