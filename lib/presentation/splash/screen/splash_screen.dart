import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/theme_data/AppColor.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 2),
      () => {

      },
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text("CENTERED LOGO"),
      ),
      backgroundColor: AppColor.Green,
    );
  }
}
