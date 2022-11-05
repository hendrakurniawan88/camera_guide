import 'dart:io';

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
  void initState() {
    super.initState();
    // initCamera();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   controller.dispose();
  // }

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
            return AspectRatio(
              aspectRatio: 2 / 3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CameraPreview(
                    controller,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [],
                    ),
                  ),
                  // AspectRatio(
                  //   aspectRatio: 2 / 3,
                  //   child: Image.asset(
                  //     'assets/images/camera-overlay-conceptcoder.png',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 65.0),
                    child: InkWell(
                      onTap: () {
                        doTakePicture();
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 48.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<void> initializeCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(
      cameras[EnumCameras.back.index],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await controller.initialize();
  }

  void doTakePicture() async {
    await controller.takePicture().then((XFile xfile) {
      if (mounted) {
        if (xfile != null) {
          showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                  title: Text('Hasil'),
                  content: SizedBox(
                    height: 200.0,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: Image.file(
                        File(xfile.path),
                        fit: BoxFit.cover,
                      ).image,
                    ),
                  ));
            }),
          );
        }
        return;
      }
    });
  }
}

enum EnumCameras { back, front }
