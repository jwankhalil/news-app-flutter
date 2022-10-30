import 'package:flutter/material.dart';
import 'package:news_app/services/utils.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, required this.text, required this.imagePath})
      : super(key: key);
  final String text, imagePath;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).getColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset(imagePath),
          ),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color, fontSize: 30, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
