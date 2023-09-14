import 'package:flutter/material.dart';

class SnackbarManager {
  static void showSnackbarNormal(String data, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(data),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
