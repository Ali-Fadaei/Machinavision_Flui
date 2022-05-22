import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:machinavision/tool_kit.dart' as T;

class BoundaryBox extends StatelessWidget {
  final List<T.SSDMobileNetResult?> boundaryResults;
  final List<dynamic> pointResult;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  const BoundaryBox.ssd(
    this.boundaryResults,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
    this.model, {
    Key? key,
  })  : pointResult = const [],
        super(key: key);

  const BoundaryBox.point(
    this.pointResult,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
    this.model, {
    Key? key,
  })  : boundaryResults = const [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      return boundaryResults.map((res) {
        var _x = res?.rect.x ?? 0.0;
        var _w = res?.rect.w ?? 0.0;
        var _y = res?.rect.y ?? 0.0;
        var _h = res?.rect.h ?? 0.0;
        var scaleW, scaleH, x, y, w, h;

        if (screenH / screenW > previewH / previewW) {
          scaleW = screenH / previewH * previewW;
          scaleH = screenH;
          var difW = (scaleW - screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = screenW / previewW * previewH;
          scaleW = screenW;
          var difH = (scaleH - screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }
        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: Container(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: T.Colors.secondary,
                width: 3.0,
              ),
            ),
            child: Text(
              '${res?.detectedClass} ${((res?.confidenceInClass ?? 0) * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                color: T.Colors.secondary,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      pointResult.forEach((res) {
        var list = res?['keypoints'].values.map<Widget>((k) {
          var _x = k['x'];
          var _y = k['y'];
          var scaleW, scaleH, x, y;

          if (screenH / screenW > previewH / previewW) {
            scaleW = screenH / previewH * previewW;
            scaleH = screenH;
            var difW = (scaleW - screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = screenW / previewW * previewH;
            scaleW = screenW;
            var difH = (scaleH - screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          return Positioned(
            left: x - 6,
            top: y - 6,
            width: 100,
            height: 12,
            child: Text(
              "● ${k["part"]}",
              style: TextStyle(
                color: T.Colors.secondary,
                fontSize: 12.0,
              ),
            ),
          );
        }).toList();

        lists.addAll(list);
      });

      return lists;
    }

    return Stack(
      children: model == T.TrainedModels.posenet
          ? _renderKeypoints()
          : _renderBoxes(),
      // return Stack(
      //   children: model == T.TrainedModels.mobilenet
      //       ? _renderStrings()
      //       : model == T.TrainedModels.posenet
      //           ? _renderKeypoints()
      //           : _renderBoxes(),
    );
  }
}
