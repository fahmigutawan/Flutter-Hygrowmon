import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/router/routes.dart';
import 'package:flutter_hygrowmon/screens/splash_screen.dart';
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
              builder: (context, state) => SplashScreen()
            )
          ]
      ),
    );
  }
}
