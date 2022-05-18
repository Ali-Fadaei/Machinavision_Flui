import 'package:flutter/material.dart';
import 'package:machinavision/tool_kit.dart' as T;

class Loading extends StatelessWidget {
  final double? sizeFactor;

  const Loading({
    Key? key,
    this.sizeFactor = 0.05,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: sizeFactor,
      widthFactor: sizeFactor,
      child: FittedBox(
        // child: Image.asset(T.Images.loading),
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(
            T.Colors.secondary,
          ),
        ),
      ),
    );
  }
}
