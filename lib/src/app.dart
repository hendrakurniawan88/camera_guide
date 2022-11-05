import 'package:camera_guide/src/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
      ),
      title: 'Camera Guide',
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: HomeScreen.routeName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          )
        ],
      ),
    );
  }
}
