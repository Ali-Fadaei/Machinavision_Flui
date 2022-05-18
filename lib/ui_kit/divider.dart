import 'package:flutter/material.dart' as M;

import 'package:machinavision/tool_kit.dart' as T;

enum DividerMode { horizantal, vertical }

class Divider extends M.StatelessWidget {
//
  final DividerMode mode;
  final M.Color color;
  final double indent;
  final double size;
  final double radius;

  Divider({
    M.Key? key,

    ///mode = DividerMode.horizantal
    this.mode = DividerMode.horizantal,

    ///color = T.ColorThemes.divider
    color,

    ///indent = 0
    this.indent = 0,

    ///size = 1
    this.size = 1,

    ///radius = 50
    this.radius = 50,
  })  : color = color ?? T.Colors.divider,
        super(key: key);

  @override
  M.Widget build(M.BuildContext context) {
    return M.Container(
      decoration: M.BoxDecoration(
        borderRadius: M.BorderRadius.circular(radius),
      ),
      child: mode == DividerMode.horizantal
          ? M.Divider(
              color: color,
              height: size,
              indent: indent,
              endIndent: indent,
            )
          : M.VerticalDivider(
              color: color,
              width: size,
              indent: indent,
              endIndent: indent,
            ),
    );
  }
}
