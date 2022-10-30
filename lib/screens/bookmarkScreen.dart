import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/seaech_screen.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:news_app/widgets/empty_widget.dart';
import 'package:page_transition/page_transition.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context: context).getScrrenSize;
    final Color color = Utils(context: context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'BookMark',
          style: GoogleFonts.lobster(
              textStyle:
                  TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
        ),
        
      ),
      body: EmptyWidget(text: "You didn\'t add anything yet to your bookmark ", imagePath: "assets/images/bookmark.png")
      /* ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ArticleWidget();
        },
      ), */
    );
  }
}
