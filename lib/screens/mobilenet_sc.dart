import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:machinavision/main.dart';
import 'package:machinavision/tool_kit.dart' as T;
import 'package:machinavision/ui_kit.dart' as U;
import 'package:tflite/tflite.dart';
import 'package:fl_chart/fl_chart.dart';

class MobileNetScreen extends StatefulWidget {
  static const route = '/objectDetector';
  const MobileNetScreen({Key? key}) : super(key: key);

  @override
  State<MobileNetScreen> createState() => _MobileNetScreenState();
}

class _MobileNetScreenState extends State<MobileNetScreen> {
//
  CameraController? cameraController;
  bool isDetecting = false;
  int startTime = 0;
  int endTime = 0;
  String resultt = '';
  List<T.MobileNetResult?> result = [];

  void loadModel() async {
    await Tflite.loadModel(
      model: 'assets/mobilenet_v1_1.0_224.tflite',
      labels: 'assets/mobilenet_v1_1.0_224.txt',
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
      resultt = '';
      result = [];
      startTime = DateTime.now().millisecondsSinceEpoch;
      Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        numResults: 6,
      ).then((recognitions) {
        endTime = DateTime.now().millisecondsSinceEpoch;
        setState(() {
          var temp = recognitions
              ?.map((e) => T.MobileNetResult(
                    index: e['index'],
                    confidence: e['confidence'],
                    label: e['label'],
                  ))
              .toList();
          result = temp ?? [];
        });
        Future.delayed(
          const Duration(seconds: 1),
          () => isDetecting = false,
        );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('MobileNet Object Detector'),
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
                padding: const EdgeInsets.fromLTRB(8, 25, 8, 5),
                // padding: const EdgeInsets.all(25),
                child: result.isNotEmpty
                    ? _BarChart(mobileNetResult: result)
                    : const U.Loading(sizeFactor: 0.2),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
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
    String text = mobileNetResult[value.toInt()]?.label ?? 'not found';
    return Center(child: Text(text, style: style));
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
    return mobileNetResult
        .asMap()
        .entries
        .map(
          (e) => BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: e.value?.percentage as double,
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          ),
        )
        .toList();
  }
}
