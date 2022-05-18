import 'package:flutter/material.dart';

abstract class Constants {
  static const int kModelInputSize = 28;
  static const double kCanvasInnerOffset = 40.0;
  static const double kCanvasSize = 200.0;
  static const double kStrokeWidth = 12.0;
  static const Color kBlackBrushColor = Colors.black;
  static const bool kIsAntiAlias = true;
  static const Color kBrushBlack = Colors.black;
  static const Color kBrushWhite = Colors.white;

  static final Paint kDrawingPaint = Paint()
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = kIsAntiAlias
    ..color = kBrushBlack
    ..strokeWidth = kStrokeWidth;

  static final Paint kWhitePaint = Paint()
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = kIsAntiAlias
    ..color = kBrushWhite
    ..strokeWidth = kStrokeWidth;

  static final kBackgroundPaint = Paint()..color = kBrushBlack;
}
