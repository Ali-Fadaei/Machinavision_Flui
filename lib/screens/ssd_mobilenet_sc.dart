import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:machinavision/main.dart';
import 'package:tflite/tflite.dart';
import 'package:machinavision/tool_kit.dart' as T;
import 'package:machinavision/ui_kit.dart' as U;
import 'dart:math' as math;

class SsdMobileNetScreen extends StatefulWidget {
  static const route = '/ssdMobilenet';
  const SsdMobileNetScreen({Key? key}) : super(key: key);

  @override
  State<SsdMobileNetScreen> createState() => _SsdMobileNetScreenState();
}

class _SsdMobileNetScreenState extends State<SsdMobileNetScreen> {
  CameraController? cameraController;
  bool isDetecting = false;
  int startTime = 0;
  int endTime = 0;
  CameraImage? image;
  List<T.SSDMobileNetResult?> result = [];

  void loadModel() async {
    await Tflite.loadModel(
      model: 'assets/ssd_mobilenet.tflite',
      labels: 'assets/ssd_mobilenet.txt',
    );
  }

  void initCamera() {
    if (cameras?.isNotEmpty ?? false) {
      cameraController = CameraController(
        cameras![0],
        ResolutionPreset.high,
      );
      cameraController?.initialize().then((value) {
        if (!mounted) return;
        setState(() {});

        cameraController?.startImageStream((image) {
          if (!isDetecting) {
            this.image = image;
            runModelOnCamera(image);
          }
        });
      });
    } else
      print('No camera is found');
  }

  void runModelOnCamera(CameraImage image) {
    if (!isDetecting) {
      isDetecting = true;
      Tflite.detectObjectOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        model: 'SSDMobileNet',
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        numResultsPerClass: 1,
        threshold: 0.4,
      ).then((recognitions) {
        setState(() {
          var temp = recognitions
              ?.map((e) => T.SSDMobileNetResult.fromMap(Map.from(e)))
              .toList();
          result = temp ?? [];
        });
        isDetecting = false;
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
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          cameraController != null
              ? SizedBox(
                  height: screen.height,
                  width: screen.width,
                  child: CameraPreview(cameraController!),
                )
              : const U.Loading(),
          U.BoundaryBox.ssd(
            result,
            math.max(image?.height ?? 1, image?.width ?? 1),
            math.min(image?.height ?? 1, image?.width ?? 1),
            screen.height,
            screen.width,
            T.TrainedModels.ssd,
          ),
          Positioned(
            bottom: 24,
            left: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                  height: 30,
                  width: screen.width - 80,
                  color: T.Colors.primary,
                  child: Center(
                    child: U.Text(
                      'SSDMobileNet Object Vision',
                      textColor: U.TextColor.white,
                      textSize: U.TextSize.lg,
                    ),
                  )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
