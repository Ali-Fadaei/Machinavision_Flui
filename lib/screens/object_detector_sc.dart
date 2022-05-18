import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:machinavision/main.dart';
import 'package:machinavision/tool_kit.dart' as T;
import 'package:machinavision/ui_kit.dart' as U;
import 'package:tflite/tflite.dart';

class ObjectDetectorScreen extends StatefulWidget {
  static const route = '/objectDetector';
  const ObjectDetectorScreen({Key? key}) : super(key: key);

  @override
  State<ObjectDetectorScreen> createState() => _ObjectDetectorScreenState();
}

class _ObjectDetectorScreenState extends State<ObjectDetectorScreen> {
//
  bool isWorking = false;
  String result = '';
  CameraController? cameraController;
  CameraImage? cameraImage;

  void loadModel() async {
    await Tflite.loadModel(
      model: 'assets/mobilenet_v1_1.0_224.tflite',
      labels: "assets/mobilenet_v1_1.0_224.txt",
    );
  }
  // void loadModel() async {
  //   await Tflite.loadModel(
  //     model: 'assets/sssd_mobilenet_v1_1_metadata_1.tflite',
  //     labels: "assets/starter.txt",
  //   );
  // }

  Future<void> initCamera() async {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController!.initialize().then((value) {
      if (!mounted) return;
      setState(() {
        cameraController!.startImageStream((image) {
          if (!isWorking) {
            isWorking = true;
            cameraImage = image;
            runModelOnCamera();
          }
        });
      });
    });
  }

  Future<void> runModelOnCamera() async {
    if (cameraImage != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((e) => e.bytes).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );

      result = "";

      recognitions?.forEach((element) {
        result += element["label"] +
            " " +
            (element["confidence"] as double).toStringAsFixed(2);

        setState(() {
          result;
        });

        isWorking = false;
      });
    }
  }

  @override
  void initState() {
    initCamera();
    loadModel();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Tflite.close();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object Detector'),
      ),
      body: Container(
        color: T.Colors.background,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: cameraController != null
                  ? AspectRatio(
                      aspectRatio: 16.0 / 9.0,
                      child: CameraPreview(cameraController!),
                    )
                  : const U.Loading(),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    U.Text(result),
                    SizedBox(
                      height: 30,
                      child: U.Button(
                        label: U.Text('show the camera'),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
