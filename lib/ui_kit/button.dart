import 'package:flutter/material.dart';

import 'package:machinavision/ui_kit.dart' as U;
import 'package:machinavision/tool_kit.dart' as T;

enum BtnType {
  elevated,
  outlined,
  text,
}

enum BtnColor {
  primary,
  secondary,
  warning,
  deleteWarning,
}

enum ButtonSize { xs, sm, md, lg, xl, xxl }

class Button extends StatelessWidget {
//
  final U.Text label;
  final void Function() onPressed;
  final String? semantic;
  final BtnType btnType;
  final BtnColor btnColor;
  final double borderRadius;
  final double heightFactor;
  final double widthFactor;
  final bool disabled;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final ButtonSize? size;
  final AlignmentGeometry? alignment;

  const Button({
    Key? key,
    required this.label,
    required this.onPressed,
    this.semantic,
    this.btnType = BtnType.elevated,
    this.btnColor = BtnColor.primary,
    this.borderRadius = 5,
    this.heightFactor = 1,
    this.widthFactor = 1,
    this.disabled = false,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.size,
    this.alignment,
  }) : super(key: key);

  const Button.elevated({
    Key? key,
    required this.label,
    required this.onPressed,
    this.semantic,
    this.btnColor = BtnColor.primary,
    this.borderRadius = 5,
    this.heightFactor = 1,
    this.widthFactor = 1,
    this.disabled = false,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.size,
    this.alignment,
  })  : btnType = BtnType.elevated,
        super(key: key);

  const Button.outlined({
    Key? key,
    required this.label,
    required this.onPressed,
    this.semantic,
    this.btnColor = BtnColor.primary,
    this.borderRadius = 5,
    this.heightFactor = 1,
    this.widthFactor = 1,
    this.disabled = false,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.size,
    this.alignment,
  })  : btnType = BtnType.outlined,
        super(key: key);

  const Button.text({
    Key? key,
    required this.label,
    required this.onPressed,
    this.semantic,
    this.btnColor = BtnColor.primary,
    this.borderRadius = 5,
    this.heightFactor = 1,
    this.widthFactor = 1,
    this.disabled = false,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.size,
    this.alignment,
  })  : btnType = BtnType.text,
        super(key: key);

  RoundedRectangleBorder get _shape {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  double get _buttonSize {
    var temp = size == null
        ? T.Utilities.isDesktop
            ? ButtonSize.sm
            : ButtonSize.md
        : size!;
    switch (temp) {
      case ButtonSize.xs:
        return 30;
      case ButtonSize.sm:
        return 35;
      case ButtonSize.md:
        return 40;
      case ButtonSize.lg:
        return 45;
      case ButtonSize.xl:
        return 50;
      case ButtonSize.xxl:
        return 55;
    }
  }

  U.Text get _label {
    return label.copyWith(
      textStyle: TextStyle(
        color: btnType == BtnType.elevated ? _colorType[1] : _colorType[0],
      ),
    );
  }

  List<Color> get _colorType {
    late Color _background;
    late Color _foreground;
    if (btnColor == BtnColor.primary) {
      if (T.Colors.themeIsLight) {
        _background = !disabled
            ? backgroundColor ?? T.Colors.primary
            : disabledBackgroundColor ?? T.Colors.disabledPrimary;
        _foreground = !disabled
            ? foregroundColor ?? T.Colors.white
            : disabledForegroundColor ?? T.Colors.disabledWhite;
      } else if (T.Colors.themeIsDark) {
        _background = !disabled
            ? backgroundColor ?? T.Colors.secondary
            : disabledBackgroundColor ?? T.Colors.disabledSecondary;
        _foreground = !disabled
            ? foregroundColor ?? T.Colors.white
            : disabledForegroundColor ?? T.Colors.disabledWhite;
      }
    } else if (btnColor == BtnColor.secondary) {
      _background = !disabled
          ? backgroundColor ?? T.Colors.secondary
          : disabledBackgroundColor ?? T.Colors.disabledSecondary;
      _foreground = !disabled
          ? foregroundColor ?? T.Colors.white
          : disabledForegroundColor ?? T.Colors.disabledWhite;
    } else if (btnColor == BtnColor.warning) {
      _background = !disabled
          ? backgroundColor ?? T.Colors.errorPrimary
          : disabledBackgroundColor ?? T.Colors.errorSecondary;
      _foreground = !disabled
          ? foregroundColor ?? T.Colors.white
          : disabledForegroundColor ?? T.Colors.errorSecondary;
    } else if (btnColor == BtnColor.deleteWarning) {
      _background = !disabled
          ? backgroundColor ?? T.Colors.deleteWarning
          : disabledBackgroundColor ?? T.Colors.disabledSecondary;
      _foreground = !disabled
          ? foregroundColor ?? T.Colors.white
          : disabledForegroundColor ?? T.Colors.deleteWarning;
    }
    return [_background, _foreground];
  }

  void Function()? _onPressed(BuildContext context) {
    if (disabled) {
      return null;
    } else {
      return () {
        if (T.Utilities.isMobile) {
          FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
        }
        onPressed();
      };
    }
  }

  Widget elevatedButtonBuilder(BuildContext context) {
    return ElevatedButton(
      child: FittedBox(fit: BoxFit.scaleDown, child: _label),
      onPressed: _onPressed(context),
      style: ButtonStyle(
        alignment: alignment,
        overlayColor: MaterialStateProperty.all(
          T.Colors.hexColor('#000000', 6),
        ),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(_colorType[0]),
        foregroundColor: MaterialStateProperty.all(_colorType[1]),
        shape: MaterialStateProperty.all(_shape),
        padding: MaterialStateProperty.all(padding),
      ),
    );
  }

  Widget outlinedButtonBuilder(BuildContext context) {
    return OutlinedButton(
      child: FittedBox(fit: BoxFit.scaleDown, child: _label),
      onPressed: _onPressed(context),
      style: ButtonStyle(
        alignment: alignment,
        overlayColor: MaterialStateProperty.all(
          T.Colors.hexColor('#000000', 3),
        ),
        elevation: MaterialStateProperty.all(0),
        foregroundColor: MaterialStateProperty.all(_colorType[0]),
        shape: MaterialStateProperty.all(_shape),
        padding: MaterialStateProperty.all(padding),
        side: MaterialStateProperty.all(BorderSide(
          color: _colorType[0],
          width: 1,
        )),
      ),
    );
  }

  Widget textButtonBuilder(BuildContext context) {
    return TextButton(
      child: FittedBox(fit: BoxFit.scaleDown, child: _label),
      onPressed: _onPressed(context),
      style: ButtonStyle(
        alignment: alignment,
        foregroundColor: MaterialStateProperty.all(_colorType[0]),
        padding: MaterialStateProperty.all(padding),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _buttonSize,
      width: double.infinity,
      child: Semantics(
        button: true,
        label: semantic,
        child: btnType == BtnType.elevated
            ? elevatedButtonBuilder(context)
            : btnType == BtnType.outlined
                ? outlinedButtonBuilder(context)
                : textButtonBuilder(context),
      ),
    );
  }
}
