import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../camera_guide/presentation/selfie_preview_screen.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Camera'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FutureBuilder(
                        future: initializeCamera(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return AspectRatio(
                              // aspectRatio: cameraController.value.aspectRatio / 2,
                              aspectRatio: 1,
                              child: CameraPreview(cameraController),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .75,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/camera-overlay-conceptcoder.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (!cameraController.value.isTakingPicture) {
                        takePicture();
                      }
                    },
                    icon: Icon(Icons.camera),
                    label: Text('Take a picture'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                          ),
                          onPressed: () async {
                            await initializeCamera();
                            setState(() {});
                          },
                          child: const Text('Open')),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            cameraController.dispose();
                          },
                          child: const Text('Closed')),
                    ],
                  ),
                )
              ],
            ),
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
            ref.read(imageResultProvider.state).state = file;
            Future.delayed(const Duration(milliseconds: 250), () {
              context.goNamed(SelfiePreviewScreen.routeName);
            });
            cameraController.dispose();
          }
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }
}
