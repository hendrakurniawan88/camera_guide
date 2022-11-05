import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CameraController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: initializeCamera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 2 / 3,
                  child: CameraPreview(controller),
                ),
                AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Image.asset(
                    'assets/images/camera-overlay-conceptcoder-2.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> initializeCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(
      cameras[EnumCameraSide.front.index],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await controller.initialize();
  }
}

enum EnumCameraSide { front, back }
