import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/presentation/onboarding/controller/onboarding_controller.dart';
import 'package:flutter_hygrowmon/presentation/onboarding/screen/onboarding_screen.dart';
import 'package:flutter_hygrowmon/presentation/splash/controller/splash_controller.dart';
import 'package:flutter_hygrowmon/router/routes.dart';
import 'package:flutter_hygrowmon/presentation/splash/screen/splash_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: Routes.Splash,
            builder: (context, state) => GetBuilder(
              init: SplashController(),
              builder: (controller) => SplashScreen(),
            ),
          ),
          GoRoute(
            path: Routes.Onboarding,
            builder: (context, state) => GetBuilder(
              init: OnboardingController(),
              builder: (controller) => OnboardingScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
