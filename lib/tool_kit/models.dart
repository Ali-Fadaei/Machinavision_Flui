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
}
