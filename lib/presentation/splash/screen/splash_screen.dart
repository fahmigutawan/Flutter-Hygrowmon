import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/main/routes.dart';
import 'package:flutter_hygrowmon/theme_data/AppColor.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 2),
      () => context.go(Routes.Lahanku),
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
            'assets/images/logo_agrisolute.png'
        ),
      ),
      backgroundColor: AppColor.White,
    );
  }
}