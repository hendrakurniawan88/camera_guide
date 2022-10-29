import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_guide/src/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageResultProvider = StateProvider<XFile?>((ref) => null);

class SelfiePreviewScreen extends HookConsumerWidget {
  const SelfiePreviewScreen({
    super.key,
  });

  static const routeName = 'selfie-preview-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageResult = ref.watch(imageResultProvider);

    return WillPopScope(
      onWillPop: () async {
        context.goNamed(HomeScreen.routeName);
        return false;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Selfie Preview'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 0,
                child: AspectRatio(
                  // aspectRatio: cameraController.value.aspectRatio / 2,
                  aspectRatio: 1 / 1,
                  child: Container(
                    child: Image.file(
                      File(imageResult!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
