// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:news_app/constants/vars.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/services/global_methods.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class BlogDetails extends StatefulWidget {
  BlogDetails({Key? key}) : super(key: key);
  static const routeName = "/BlogDetails";
  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context: context).getScrrenSize;
    final Color color = Utils(context: context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    final String publishAt =
        ModalRoute.of(context)!.settings.arguments as String;
    final currentNews = newsProvider.findByDate(publishAt: publishAt);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "By ${currentNews.authorName}",
          textAlign: TextAlign.center,
          style: TextStyle(color: color),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentNews.title,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                VerticalSpacing(25),
                Row(
                  children: [
                    Text(
                      currentNews.dateToShow,
                      style: smallTextStyle,
                    ),
                    Spacer(),
                    Text(
                      currentNews.readingTimeText,
                      style: smallTextStyle,
                    )
                  ],
                ),
                VerticalSpacing(20),
              ],
            ),
          ),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Hero(
                    tag: currentNews.publishedAt,
                    child: FancyShimmerImage(
                      boxFit: BoxFit.fill,
                      errorWidget: Image.asset("assets/images/empty_image.png"),
                      imageUrl: currentNews.urlToImage,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          try {
                            await Share.share(currentNews.url,
                                subject: 'Look what I made!');
                          } catch (error) {
                            GlobalMethods.errorDialog(
                                text: error.toString(), context: context);
                          }
                        },
                        child: Card(
                          elevation: 10,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              IconlyLight.send,
                              size: 28,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 10,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              IconlyLight.bookmark,
                              size: 28,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          VerticalSpacing(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextContent(
                    label: "Description",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                VerticalSpacing(10),
                TextContent(
                    label: currentNews.description,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
                VerticalSpacing(20),
                TextContent(
                    label: "Content",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                VerticalSpacing(10),
                TextContent(
                    label: currentNews.content,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({
    Key? key,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      label,
      textAlign: TextAlign.justify,
      style: GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
