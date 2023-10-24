import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/main/bloc/main_bloc.dart';
import 'package:flutter_hygrowmon/main/bloc/main_state.dart';
import 'package:flutter_hygrowmon/presentation/monitoring/controller/monitoring_controller.dart';
import 'package:flutter_hygrowmon/presentation/splash/controller/splash_controller.dart';
import 'package:flutter_hygrowmon/main/routes.dart';
import 'package:flutter_hygrowmon/presentation/splash/screen/splash_screen.dart';
import 'package:flutter_hygrowmon/widgets/scaffold_with_navbar.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../presentation/monitoring/screen/monitoring_screen.dart';
import '../theme_data/AppColor.dart';

class AppRouter extends StatefulWidget {
  AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final mainBloc = MainBloc(MainInitial());

    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: AppColor.DarkBrown,
              foregroundColor: AppColor.White,
              minimumSize: Size(
                double.infinity,
                48,
              ),
              textStyle: TextStyle(
                fontFamily: "Poppins Semibold",
                color: AppColor.White,
              )),
        ),
        textTheme: TextTheme(
            displayLarge: TextStyle(fontFamily: "Poppins Regular"),
            displayMedium: TextStyle(fontFamily: "Poppins Medium"),
            displaySmall: TextStyle(fontFamily: "Poppins Medium"),
            headlineLarge: TextStyle(fontFamily: "Poppins Regular"),
            headlineMedium: TextStyle(fontFamily: "Poppins Medium"),
            headlineSmall: TextStyle(fontFamily: "Poppins Medium"),
            titleLarge: TextStyle(fontFamily: "Poppins Regular"),
            titleMedium: TextStyle(fontFamily: "Poppins Medium"),
            titleSmall: TextStyle(fontFamily: "Poppins Medium"),
            bodyLarge: TextStyle(fontFamily: "Poppins Regular"),
            bodyMedium: TextStyle(fontFamily: "Poppins Medium"),
            bodySmall: TextStyle(fontFamily: "Poppins Medium"),
            labelLarge: TextStyle(fontFamily: "Poppins Regular"),
            labelMedium: TextStyle(fontFamily: "Poppins Medium"),
            labelSmall: TextStyle(fontFamily: "Poppins Medium")),
      ),
      routerConfig: GoRouter(
        initialLocation: Routes.Splash,
        navigatorKey: _rootNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: Routes.Splash,
            builder: (context, state) => GetBuilder(
              init: SplashController(),
              builder: (controller) => SplashScreen(),
            ),
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: Routes.Lahanku,
            builder: (context, state) => GetBuilder(
              init: MonitoringController(),
              builder: (_) => MonitoringScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
