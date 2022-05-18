import 'package:flutter/material.dart';
import 'package:machinavision/ui_kit.dart' as U;
import 'package:machinavision/tool_kit.dart' as T;

class HeaderBox extends StatelessWidget {
  //
  final String? header;
  final Widget? leftHeader;
  final List<Widget>? children;
  final Widget? child;
  final EdgeInsets padding;

  const HeaderBox({
    Key? key,
    this.header,
    this.leftHeader,
    this.child,
    this.children,
    this.padding = const EdgeInsets.all(25),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: T.Colors.headerBox, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null) U.Header(title: header, leftTitle: leftHeader),
          Padding(
            padding: padding,
            child: child ??
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children!,
                ),
          ),
        ],
      ),
    );
  }
}
