import 'package:flutter/material.dart';
import 'package:machinavision/tool_kit.dart' as T;

class DrawingPainter extends CustomPainter {
  DrawingPainter({this.offsetPoints});
  List<Offset?>? offsetPoints;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < (offsetPoints?.length ?? 0) - 1; i++) {
      if (offsetPoints?[i] != null && offsetPoints?[i + 1] != null) {
        canvas.drawLine(offsetPoints![i]!, offsetPoints![i + 1]!,
            T.Constants.kDrawingPaint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
