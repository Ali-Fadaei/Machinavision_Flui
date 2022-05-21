abstract class TrainedModels {
  static const mobilenet = 'MobileNet';
  static const ssd = 'SSD MobileNet';
  static const yolo = 'Tiny YOLOv2';
  static const posenet = 'PoseNet';
}

class MobileNetResult {
  int index;
  double confidence;
  String label;
  late double percentage;

  MobileNetResult({
    this.index = -1,
    this.confidence = 0.0,
    this.label = 'not found',
  }) : percentage = double.parse(confidence.toStringAsFixed(2)) * 100;

  factory MobileNetResult.fromMap(Map<String, dynamic>? json) =>
      MobileNetResult(
        index: json?['index'],
        confidence: json?['confidence'],
        label: json?['label'],
      );
}

class SSDMobileNetResult {
  Rect rect;
  double confidenceInClass;
  String detectedClass;
  late double percentage;

  SSDMobileNetResult({
    this.rect = const Rect(w: 0, h: 0, x: 0, y: 0),
    this.confidenceInClass = 0.0,
    this.detectedClass = 'not found',
  }) : percentage = double.parse(confidenceInClass.toStringAsFixed(2)) * 100;

  factory SSDMobileNetResult.fromMap(Map<String, dynamic>? json) =>
      SSDMobileNetResult(
        rect: Rect.fromMap(Map.from(json?['rect'])),
        confidenceInClass: json?['confidenceInClass'],
        detectedClass: json?['detectedClass'],
      );
}

class Rect {
  final double w;
  final double x;
  final double h;
  final double y;

  const Rect({
    this.w = 0.0,
    this.x = 0.0,
    this.h = 0.0,
    this.y = 0.0,
  });

  factory Rect.fromMap(Map<String, dynamic>? json) => Rect(
        w: json?['w'],
        x: json?['x'],
        h: json?['h'],
        y: json?['y'],
      );
}
