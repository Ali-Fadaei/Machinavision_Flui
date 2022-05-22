import 'package:flutter/material.dart';
import 'package:machinavision/screens/handwriting_sc.dart';
import 'package:machinavision/screens/mobilenet_sc.dart';
import 'package:machinavision/screens/posenet_sc.dart';
import 'package:machinavision/screens/ssd_mobilenet_sc.dart';
import 'package:machinavision/screens/tiny_yolo_sc.dart';
import 'package:machinavision/ui_kit.dart' as U;

class MainPanelScreen extends StatelessWidget {
  static const route = '/';
  const MainPanelScreen({Key? key}) : super(key: key);

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
        child: ListView(
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
          ],
        ),
      ),
    );
  }
}
