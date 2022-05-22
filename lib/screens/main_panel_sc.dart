import 'package:flutter/material.dart';
import 'package:machinavision/main.dart';
import 'package:machinavision/screens/handwriting_sc.dart';
import 'package:machinavision/screens/mobilenet_sc.dart';
import 'package:machinavision/screens/posenet_sc.dart';
import 'package:machinavision/screens/ssd_mobilenet_sc.dart';
import 'package:machinavision/screens/tiny_yolo_sc.dart';
import 'package:machinavision/ui_kit.dart' as U;

class MainPanelScreen extends StatefulWidget {
  static const route = '/';
  const MainPanelScreen({Key? key}) : super(key: key);

  @override
  State<MainPanelScreen> createState() => _MainPanelScreenState();
}

class _MainPanelScreenState extends State<MainPanelScreen> {
  String get selectedCameraName =>
      selectedCamera == cameras![0] ? 'Back Camera' : 'Front Camera';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MachinaVision'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: U.Button(
                label: U.Text('MobileNet Object Vision'),
                onPressed: () =>
                    Navigator.of(context).pushNamed(MobileNetScreen.route),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              child: U.Button(
                label: U.Text('SSDMobileNet Object Vision'),
                onPressed: () =>
                    Navigator.of(context).pushNamed(SsdMobileNetScreen.route),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              child: U.Button(
                label: U.Text('YOLO Object Vision'),
                onPressed: () =>
                    Navigator.of(context).pushNamed(TinyYoloScreen.route),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              child: U.Button(
                label: U.Text('PoseNet Gesture Vision'),
                onPressed: () =>
                    Navigator.of(context).pushNamed(PoseNetScreen.route),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              child: U.Button(
                label: U.Text('Handwriting Detector'),
                onPressed: () =>
                    Navigator.of(context).pushNamed(HandWritingScreen.route),
              ),
            ),
            const Spacer(),
            U.Text('selected Camera: $selectedCameraName'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cameraswitch_sharp),
        onPressed: () {
          print('cameras?.length');
          print(cameras?.length);
          setState(() {
            selectedCamera =
                selectedCamera == cameras![0] ? cameras![1] : cameras![0];
          });
        },
      ),
    );
  }
}
