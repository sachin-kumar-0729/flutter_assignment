import 'package:flutter/material.dart';


double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Future waitFor(int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
}

void showSnackBar(
    {required String message,
    required BuildContext context,
    int miliSec = 1500}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: miliSec),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black));
}

class Utility {
  static void showSnackBar(
      {required String message,
      required BuildContext context,
      int miliSec = 1500}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: miliSec),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black));
  }
}
