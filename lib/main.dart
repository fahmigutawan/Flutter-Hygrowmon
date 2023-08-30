import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/di/injection.dart';
import 'package:flutter_hygrowmon/router/app_router.dart';

import 'theme_data/AppColor.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: AppColor.Green,
              body: SafeArea(
                child: AppRouter(),
              ),
            );
          } else {
            return Scaffold(
              body: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        future: locator.allReady(),
      ),
    );
  }
}
