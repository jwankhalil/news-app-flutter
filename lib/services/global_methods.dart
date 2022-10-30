// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';

class GlobalMethods {
  static String formattedDateText(String publishAt) {
    final parseData = DateTime.parse(publishAt);
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(parseData);
    DateTime publishDate =
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(formattedDate);
    return '${publishDate.day}/${publishDate.month}/${publishDate.year} ON ${publishDate.hour}:${publishDate.minute}:${publishDate.hour}';
  }

  static Future<void> errorDialog(
      {required String text, required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(text),
          title: (Row(
            children: [
              const Icon(
                IconlyBold.danger,
                color: Colors.red,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text("An error occured")
            ],
          )),
          actions: [
            TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text("ok"))
          ],
        );
      },
    );
  }
}
