import 'package:flutter/material.dart';
import 'package:machinavision/tool_kit.dart' as T;
import 'package:machinavision/ui_kit.dart' as U;

class HandWritingScreen extends StatefulWidget {
  static const route = '/handWritingRecognizer';
  const HandWritingScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<HandWritingScreen> createState() => _RecognizerScreen();
}

class _RecognizerScreen extends State<HandWritingScreen> {
  List<Offset?> points = [];
  T.AppBrain brain = T.AppBrain();

  void _cleanDrawing() {
    setState(() {
      points = [];
    });
  }

  @override
  void initState() {
    super.initState();
    brain.loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Handwriting Detector'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text('Header'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 3.0,
                color: Colors.blue,
              ),
            ),
            child: Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      points
                          .add(renderBox.globalToLocal(details.globalPosition));
                    });
                  },
                  onPanStart: (details) {
                    setState(() {
                      RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      points
                          .add(renderBox.globalToLocal(details.globalPosition));
                    });
                  },
                  onPanEnd: (details) async {
                    points.add(null);
                    List predictions =
                        await brain.processCanvasPoints(points) as List;
                    print(predictions);
                    setState(() {});
                  },
                  child: ClipRect(
                    child: CustomPaint(
                      size: const Size(
                          T.Constants.kCanvasSize, T.Constants.kCanvasSize),
                      painter: U.DrawingPainter(
                        offsetPoints: points,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text('Footer'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _cleanDrawing();
        },
        tooltip: 'Clean',
        child: const Icon(Icons.delete),
      ),
    );
  }
}
