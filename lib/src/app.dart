import 'package:camera/camera.dart';
import 'package:camera_guide/src/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/camera_guide/presentation/selfie_preview_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Camera Guide with Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: HomeScreen.routeName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
              path: '/selfie-preview',
              name: SelfiePreviewScreen.routeName,
              pageBuilder: (context, state) {
                final extra = state.extra as XFile;
                return NoTransitionPage(
                  child: SelfiePreviewScreen(imageResult: extra),
                );
              }),
        ],
      ),
    );
  }
}
