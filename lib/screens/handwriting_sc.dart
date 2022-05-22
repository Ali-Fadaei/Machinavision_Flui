import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:machinavision/tool_kit.dart' as T;
import 'package:machinavision/ui_kit.dart' as U;
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' hide Image;
import 'package:flutter/services.dart';
import 'package:image/image.dart' as im;
import 'package:tflite/tflite.dart';

class HandWritingScreen extends StatefulWidget {
  static const route = '/handWritingRecognizer';
  const HandWritingScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<HandWritingScreen> createState() => _RecognizerScreen();
}

class _RecognizerScreen extends State<HandWritingScreen> {
  List<Offset?> points = [];
  List<T.MobileNetResult?> result = [];

  Future loadModel() async {
    Tflite.close();
    try {
      await Tflite.loadModel(
        model: 'assets/converted_mnist_model.tflite',
        labels: 'assets/labels.txt',
      );
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Future<List?> processCanvasPoints(List<Offset?> points) async {
    // We create an empty canvas 280x280 pixels
    const canvasSizeWithPadding =
        T.Constants.kCanvasSize + (2 * T.Constants.kCanvasInnerOffset);
    const canvasOffset = Offset(
      T.Constants.kCanvasInnerOffset,
      T.Constants.kCanvasInnerOffset,
    );
    final recorder = PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromPoints(
        const Offset(0.0, 0.0),
        const Offset(canvasSizeWithPadding, canvasSizeWithPadding),
      ),
    );

    // Our image is expected to have a black background and a white drawing trace,
    // quite the opposite of the visual representation of our canvas on the screen
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, canvasSizeWithPadding, canvasSizeWithPadding),
      T.Constants.kBackgroundPaint,
    );

    // Now we draw our list of points on white paint
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
          points[i]! + canvasOffset,
          points[i + 1]! + canvasOffset,
          T.Constants.kWhitePaint,
        );
      }
    }

    // At this point our virtual canvas is ready and we can export an image from it
    final picture = recorder.endRecording();
    final img = await picture.toImage(
      canvasSizeWithPadding.toInt(),
      canvasSizeWithPadding.toInt(),
    );
    final imgBytes = await img.toByteData(format: ImageByteFormat.png);
    Uint8List pngUint8List = imgBytes?.buffer.asUint8List() ?? Uint8List(0);

    // There's quite a funny game at this point. The image class we are using doesn't allow resizing.
    // In order to achieve that, we need to convert it to another image class that we are importing
    // as 'im' from package:image/image.dart

    im.Image? imImage = im.decodeImage(pngUint8List);
    im.Image resizedImage = im.copyResize(
      imImage!,
      width: T.Constants.kModelInputSize,
      height: T.Constants.kModelInputSize,
    );

    // Finally, we can return our the prediction we will perform over that
    // resized image
    return predictImage(resizedImage);
  }

  Future<List?> predictImage(im.Image image) async {
    return await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(image, T.Constants.kModelInputSize),
    );
  }

  Uint8List imageToByteListFloat32(im.Image image, int inputSize) {
    var convertedBytes = Float32List(inputSize * inputSize);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] =
            (im.getRed(pixel) + im.getGreen(pixel) + im.getBlue(pixel)) /
                3 /
                255.0;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  double convertPixel(int color) {
    return (255 -
            (((color >> 16) & 0xFF) * 0.299 +
                ((color >> 8) & 0xFF) * 0.587 +
                (color & 0xFF) * 0.114)) /
        255.0;
  }

  void _cleanDrawing() {
    setState(() {
      points = [];
    });
  }

  @override
  void initState() {
    super.initState();
    loadModel();
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
              alignment: Alignment.bottomCenter,
              child: U.Text('Please Draw a number below:'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 3.0,
                color: T.Colors.primary,
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
                        await processCanvasPoints(points) as List;

                    setState(() {
                      result = predictions
                          .map((e) => T.MobileNetResult.fromMap(Map.from(e)))
                          .toList();
                      print(predictions);
                    });
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
          const SizedBox(height: 30),
          Expanded(
            flex: 3,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 25, 8, 5),
                child: _BarChart(mobileNetResult: result)),
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _cleanDrawing();
            result = [];
          });
        },
        tooltip: 'Clean',
        child: const Icon(Icons.delete),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _BarChart extends StatelessWidget {
  final List<T.MobileNetResult?> mobileNetResult;

  const _BarChart({
    Key? key,
    this.mobileNetResult = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Color.fromARGB(255, 78, 99, 124),
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: T.Colors.primary2,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    // String text = mobileNetResult[value.toInt()]?.label ?? 'not found';
    return Center(child: Text(value.toInt().toString(), style: style));
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  get _barsGradient => LinearGradient(
        colors: [
          T.Colors.primary,
          T.Colors.secondary,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups {
    var digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    return digits.map((e) {
      double temp = 0;
      try {
        temp = mobileNetResult
                .firstWhere((element) => element?.label == e.toString())
                ?.percentage ??
            0;
      } catch (_) {
        temp = 0;
      }
      return BarChartGroupData(
        x: e,
        barRods: [
          BarChartRodData(
            toY: temp,
            // toY: mobileNetResult[e]?.percentage ?? 0 as double,
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
  }
}
