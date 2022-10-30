// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/bookmarkScreen.dart';

import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image(
                      image: AssetImage('assets/images/newspaper.png'),
                      height: 60,
                      width: 60,
                    ),
                  ),
                  VerticalSpacing(20),
                  Text('News App',style: GoogleFonts.lobster(
                    textStyle: TextStyle(fontSize: 20,letterSpacing: 0.5)
                  ),),
                ],
              ),
            ),
            VerticalSpacing(20),
            ListTiles(
              label: "Home",
              icon: IconlyBold.home,
              function: () {},
            ),
            ListTiles(
              label: "BookMark",
              icon: IconlyBold.bookmark,
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: BookMarkScreen(),
                      type: PageTransitionType.rightToLeft,
                      //inheritTheme: true
                      ),
                );
              },
            ),
            Divider(
              thickness: 3,
            ),
            SwitchListTile(
              title: Text(
                themeProvider.getDarkTheme ? 'Dark' : 'Light',
                 style: TextStyle(fontSize: 20),
              ),
              secondary: Icon(
                themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.secondary,
              ),
              value: themeProvider.getDarkTheme,
              onChanged: (bool value) {
                setState(() {
                  themeProvider.setDarkTheme = value;
                });
              }),
          ],
        ),
      ),
    );
  }
}

class ListTiles extends StatelessWidget {
  ListTiles({
    Key? key,
    required this.label,
    required this.function,
    required this.icon,
  }) : super(key: key);
  final String label;
  final Function function;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(fontSize: 20),
      ),
      leading: Icon(icon,color: Theme.of(context).colorScheme.secondary,),
      onTap: () {
        function();
      },
    );
  }
}
