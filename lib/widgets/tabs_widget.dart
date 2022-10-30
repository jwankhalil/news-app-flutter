// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TabsWidget extends StatelessWidget {
  const TabsWidget({
    required this.text,
    required this.color,
    required this.function,
    required this.fontSize,
  });
  final String text;
  final Color color;
  final Function function;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: color),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
