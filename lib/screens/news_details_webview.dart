// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:news_app/services/global_methods.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsWebView extends StatefulWidget {
  NewsDetailsWebView({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  State<NewsDetailsWebView> createState() => _NewsDetailsWebViewState();
}

class _NewsDetailsWebViewState extends State<NewsDetailsWebView> {
  late WebViewController _webViewController;
  double _progress = 0.0;
 
  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context: context).getScrrenSize;
    final Color color = Utils(context: context).getColor;
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(IconlyLight.arrowLeft2),
          ),
          iconTheme: IconThemeData(color: color),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.url,
            style: TextStyle(color: color),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await _showModelSheet();
              },
              icon: Icon(Icons.more_horiz),
            )
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color: _progress == 1 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebView(
                initialUrl: widget.url,
                zoomEnabled: true,
                onProgress: (progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  Future<void> _showModelSheet() async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VerticalSpacing(20),
              Container(
                height: 5,
                width: 44,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30)),
              ),
              VerticalSpacing(20),
              Text(
                "More option",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              VerticalSpacing(20),
              Divider(
                thickness: 2,
              ),
              VerticalSpacing(20),
              BottomListTile(
                  text: "Share",
                  icon: Icons.share,
                  function: () async {
                    
                    try {
                    await  Share.share(widget.url, subject: 'Look what I made!');
                    } catch (error) {
                      GlobalMethods.errorDialog(text: error.toString(), context: context);
                    }
                  }),
              BottomListTile(
                  text: "Open in browser",
                  icon: Icons.open_in_browser,
                  function: () async {
                    if (!await launchUrl(Uri.parse(widget.url))) {
                      throw 'Could not launch ${widget.url}';
                    }
                  }),
              BottomListTile(
                  text: "Refresh",
                  icon: Icons.refresh,
                  function: () async {
                    try {
                      await _webViewController.reload();
                    } catch (e) {
                    } finally {
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        );
      },
    );
  }
}

class BottomListTile extends StatelessWidget {
  BottomListTile(
      {required this.text, required this.icon, required this.function});
  IconData icon;
  Function function;
  String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        function();
      },
    );
  }
}
