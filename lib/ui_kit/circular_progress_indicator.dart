import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vmath;
import 'package:machinavision/tool_kit.dart' as T;

class CircularProgressIndicator extends StatefulWidget {
  final double? width;
  final double? height;
  final double? strokeWidth;
  final double? strokeWidthUnder;
  final bool startExp;
  final Duration? duration;
  final List<ValueCircularProgressModel>? values;
  final Color? strokeUnderColor;

  const CircularProgressIndicator({
    Key? key,
    this.width,
    this.height,
    this.strokeWidth,
    this.strokeWidthUnder,
    this.strokeUnderColor,
    this.duration,
    this.startExp = false,
    this.values,
  }) : super(key: key);

  @override
  _CircularProgressIndicatorState createState() =>
      _CircularProgressIndicatorState();
}

class _CircularProgressIndicatorState extends State<CircularProgressIndicator>
    with TickerProviderStateMixin {
  //
  AnimationController? controller;
  Animation? animation;

  @override
  void didUpdateWidget(covariant CircularProgressIndicator oldWidget) {
    if (!oldWidget.startExp && widget.startExp) {
      controller = AnimationController(
        vsync: this,
        duration: widget.duration ?? const Duration(seconds: 3),
      )..addListener(() {
          setState(() {});
        });
      controller?.forward();
      animation =
          CurvedAnimation(parent: controller!, curve: Curves.linearToEaseOut);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 160,
      height: widget.height ?? 160,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
            color: T.Colors.background,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: T.Colors.panelCard,
              ),
              child: LayoutBuilder(
                builder: (context, boxConstraints) {
                  return Center(
                    child: Stack(
                      children: [
                        ...widget.values!.asMap().entries.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomPaint(
                              painter: _CustomCircularProgress(
                                animationValue:
                                    widget.startExp ? animation?.value : null,
                                value: (e.value.percentage * 360) / 100,
                                width: boxConstraints.maxWidth -
                                    (2 * (15 * (e.key + 1))),
                                height: boxConstraints.maxHeight -
                                    (2 * (15 * (e.key + 1))),
                                strokeWidth: widget.strokeWidth,
                                strokeWidthUnder: widget.strokeWidthUnder,
                                strokeColor: e.value.color,
                                strokeUnderColor: widget.strokeUnderColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomCircularProgress extends CustomPainter {
  final double value;
  final double? animationValue;
  final double width;
  final double height;
  final double? strokeWidth;
  final double? strokeWidthUnder;
  final Color strokeColor;
  final Color? strokeUnderColor;

  _CustomCircularProgress({
    required this.value,
    required this.width,
    required this.height,
    this.animationValue,
    this.strokeWidth,
    this.strokeWidthUnder,
    required this.strokeColor,
    this.strokeUnderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawArc(
      Rect.fromCenter(center: center, width: width, height: height),
      vmath.radians(1),
      vmath.radians(360),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = strokeUnderColor ?? T.Colors.background
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidthUnder ?? 3,
    );
    canvas.saveLayer(
      Rect.fromCenter(center: center, width: width + 10, height: height + 10),
      Paint(),
    );
    canvas.drawArc(
      Rect.fromCenter(center: center, width: width, height: height),
      vmath.radians(270),
      vmath.radians(value * (animationValue ?? 1)),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = strokeColor
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth ?? 10,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ValueCircularProgressModel {
  final double percentage;
  final Color color;

  ValueCircularProgressModel({
    required this.percentage,
    required this.color,
  });
}
