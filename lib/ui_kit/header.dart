import 'package:flutter/material.dart';
import 'package:machinavision/tool_kit.dart' as T;
import 'package:machinavision/ui_kit.dart' as U;

class Header extends StatelessWidget {
  final U.Text? text;
  final String? title;
  final Widget? leftTitle;
  final Color? backgroundColor;
  final double verticalPadding;
  final double horizontalPadding;

  const Header({
    Key? key,
    this.text,
    this.title,
    this.leftTitle,
    this.backgroundColor,
    this.verticalPadding = 12,
    this.horizontalPadding = 20,
  }) : super(key: key);

  Color get _backgroundColor {
    return backgroundColor ?? T.Colors.header;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      color: backgroundColor,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          text != null
              ? text!
              : U.Text(
                  title ?? '',
                  textSize: U.TextSize.lg,
                  textAlign: TextAlign.right,
                  textColor: U.TextColor.primary2,
                  textWeight: U.TextWeight.medium,
                ),
          const Spacer(),
          leftTitle ?? Container(),
        ],
      ),
    );
  }
}
