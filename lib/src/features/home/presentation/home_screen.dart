import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../camera_guide/presentation/selfie_preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    // initializeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  Future<void> initializeCamera() async {
    var cameras = await availableCameras();
    cameraController = CameraController(
      cameras[1],
      ResolutionPreset.medium,
      imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.jpeg : ImageFormatGroup.yuv420,
    );
    await cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("${cameraController.value.aspectRatio}");
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Camera Guide'),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: [
                  FutureBuilder(
                    future: initializeCamera(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          // aspectRatio: cameraController.value.aspectRatio / 2,
                          aspectRatio: 2 / 3,
                          key: const Key('camera-preview'),
                          child: CameraPreview(cameraController),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  AspectRatio(
                    key: const Key('camera-preview'),
                    // aspectRatio: cameraController.value.aspectRatio / 2,
                    aspectRatio: 2 / 3,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 1,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/camera-overlay-conceptcoder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50.0,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (!cameraController.value.isTakingPicture) {
                          takePicture();
                        }
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text('Take a picture'),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 32.0,
                      ),
                      onPressed: () {
                        cameraController.dispose();
                        setState(() {});
                        // exit(0);
                      },
                    ),
                  ),
                ],
              ),
              // Expanded(
              //   flex: 0,
              //   child: Column(
              //     children: [
              //       ElevatedButton.icon(
              //         onPressed: () {
              //           if (!cameraController.value.isTakingPicture) {
              //             takePicture();
              //           }
              //         },
              //         icon: const Icon(Icons.camera),
              //         label: const Text('Take a picture'),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             ElevatedButton(
              //                 style: ElevatedButton.styleFrom(
              //                   backgroundColor: Colors.teal,
              //                 ),
              //                 onPressed: () async {
              //                   await initializeCamera();
              //                   setState(() {});
              //                 },
              //                 child: const Text('Open')),
              //             ElevatedButton(
              //                 style: ElevatedButton.styleFrom(
              //                   backgroundColor: Colors.red,
              //                 ),
              //                 onPressed: () {
              //                   cameraController.dispose();
              //                 },
              //                 child: const Text('Closed')),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void takePicture() async {
    try {
      await cameraController.takePicture().then((XFile? file) {
        if (mounted) {
          if (file != null) {
            Future.delayed(const Duration(milliseconds: 250), () {
              context.goNamed(
                SelfiePreviewScreen.routeName,
                extra: file,
              );
              // cameraController.dispose();
            });
          }
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }
}
