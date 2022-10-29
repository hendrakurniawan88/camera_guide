//go_router

import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';

import '../features/camera_guide/presentation/selfie_preview_screen.dart';
import '../features/home/presentation/home_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      pageBuilder: (context, state) => const NoTransitionPage(child: HomeScreen()),
    ),
    GoRoute(
      path: '/selfie-preview-screen',
      name: SelfiePreviewScreen.routeName,
      pageBuilder: (context, state) {
        // final paramExtra = state.extra as XFile?;
        return const NoTransitionPage(
          child: SelfiePreviewScreen(),
        );
      },
    ),
  ],
);
