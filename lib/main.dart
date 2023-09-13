import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/di/injection.dart';
import 'package:flutter_hygrowmon/router/app_router.dart';

import 'theme_data/AppColor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agrisolute',
      home: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: AppRouter(),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        },
        future: locator.allReady(),
      ),
    );
  }
}
