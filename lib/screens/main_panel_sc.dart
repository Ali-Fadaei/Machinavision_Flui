import 'package:flutter/material.dart';
import 'package:machinavision/screens/handwriting_sc.dart';
import 'package:machinavision/screens/mobilenet_sc.dart';
import 'package:machinavision/ui_kit.dart' as U;

class MainPanelScreen extends StatelessWidget {
  static const route = '/main';
  const MainPanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Powered App'),
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
                label: U.Text('MobileNet Object Detector'),
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
                label: U.Text('Handwriting Detector'),
                onPressed: () =>
                    Navigator.of(context).pushNamed(HandWritingScreen.route),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              child: U.Button(
                label: U.Text('Test Detector'),
                onPressed: () {},
                disabled: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              child: U.Button(
                label: U.Text('Test1 Detector'),
                onPressed: () {},
                disabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
