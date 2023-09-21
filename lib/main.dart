import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/di/injection.dart';
import 'package:flutter_hygrowmon/router/app_router.dart';

import 'theme_data/AppColor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    final repo = locator.get<Repository>();
    repo.disconnectMqtt();
    super.dispose();
  }

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
            return SingleChildScrollView(
              child: Container(
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
