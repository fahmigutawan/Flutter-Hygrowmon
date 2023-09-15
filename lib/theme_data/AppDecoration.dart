import 'package:flutter/material.dart';

import 'AppColor.dart';

class AppDecoration {
  static const InputDecoration outlinedTextField = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white60,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.Green,
      ),
    ),
  );

  static const InputDecoration outlinedTextFieldInverted = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white60,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.White,
          width: 2,
        ),
      ),
      labelStyle: TextStyle(color: AppColor.White));

  static const InputDecoration outlinedDropdownInverted = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white60,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.White,
        width: 2,
      ),
    ),
    labelStyle: TextStyle(color: AppColor.White)
  );
}
