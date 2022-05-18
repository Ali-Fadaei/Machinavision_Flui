import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart' as M;

import 'package:machinavision/tool_kit.dart' as T;

enum TextSize { xs, sm, md, lg, xl, xxl }
enum TextWeight { light, regular, medium, bold }
enum TextColor {
  primary,
  primary2,
  secondary,
  white,
  background,
  grey,
  disabledText,
  black,
  deleteWarning,
  primaryDisabled,
  success,
  errorWarning,
  subRoute,
  disabledSubRoute,
}

class Text extends M.StatelessWidget {
//
  final String content;

  final bool autoSize;

  ///maxLine = 1
  final int? maxLines;

  ///minFontSize = 8
  final double? minFontSize;

  ///textSize => win = md , android = lg
  final TextSize? textSize;

  ///textWeight = TextWeight.regular
  final TextWeight textWeight;

  ///textColor = TextColor.primary2
  final TextColor textColor;

  ///textDirection = M.TextDirection.ltr
  final M.TextDirection? textDirection;

  ///textAlign = M.TextAlign.center
  final M.TextAlign textAlign;

  ///optional for Control Text overFlow
  final M.TextOverflow? overflow;

  ///optional for overriding all styles
  final M.TextStyle? textStyle;

  final _isDesktop = T.Utilities.isDesktop;

  Text(
    this.content, {
    M.Key? key,
    this.textSize,
    this.overflow,
    this.textStyle,
    this.textWeight = TextWeight.regular,
    this.textColor = TextColor.primary2,
    this.textDirection,
    this.textAlign = M.TextAlign.center,
  })  : autoSize = false,
        maxLines = null,
        minFontSize = null,
        super(key: key);

  Text.autoSize(
    this.content, {
    M.Key? key,
    this.textSize,
    this.overflow,
    this.textStyle,
    this.maxLines = 1,
    this.minFontSize = 10,
    this.textWeight = TextWeight.regular,
    this.textColor = TextColor.primary2,
    this.textDirection,
    this.textAlign = M.TextAlign.center,
  })  : autoSize = true,
        super(key: key);

  double get _fontSize {
    var temp = textSize == null
        ? _isDesktop
            ? TextSize.md
            : TextSize.lg
        : textSize!;
    switch (temp) {
      case TextSize.xs:
        return 10.0;
      case TextSize.sm:
        return 12.0;
      case TextSize.md:
        return 14.0;
      case TextSize.lg:
        return 16.0;
      case TextSize.xl:
        return 18.0;
      case TextSize.xxl:
        return 20.0;
    }
  }

  M.FontWeight get _fontWeight {
    switch (textWeight) {
      case TextWeight.light:
        return M.FontWeight.w100;
      case TextWeight.regular:
        return M.FontWeight.normal;
      case TextWeight.medium:
        return M.FontWeight.w500;
      case TextWeight.bold:
        return M.FontWeight.w700;
    }
  }

  M.Color get _color {
    switch (textColor) {
      case TextColor.primary2:
        return T.Colors.primary2;
      case TextColor.white:
        return T.Colors.white;
      case TextColor.primary:
        return T.Colors.primary;
      case TextColor.secondary:
        return T.Colors.secondary;
      case TextColor.background:
        return T.Colors.background;
      case TextColor.subRoute:
        return T.Colors.subRouteText;
      case TextColor.disabledSubRoute:
        return T.Colors.disabledSubRouteText;
      case TextColor.grey:
        return T.Colors.disabledPrimary2;
      case TextColor.disabledText:
        return T.Colors.disabledText;
      case TextColor.black:
        return M.Colors.black;
      case TextColor.deleteWarning:
        return T.Colors.deleteWarning;
      case TextColor.primaryDisabled:
        return T.Colors.disabledPrimary;
      case TextColor.success:
        return T.Colors.successPrimary;
      case TextColor.errorWarning:
        return T.Colors.errorWarning;
    }
  }

  M.TextStyle get _textStyle {
    return textStyle ??
        M.TextStyle(
          fontSize: _fontSize,
          fontWeight: _fontWeight,
          color: _color,
        );
  }

  Text copyWith({
    String? content,
    TextSize? textSize,
    TextColor? textColor,
    TextWeight? textWeight,
    M.TextAlign? textAlign,
    M.TextOverflow? overflow,
    M.TextStyle? textStyle,
    M.TextDirection? textDirection,
  }) {
    return Text(
      content ?? this.content,
      textSize: textSize ?? this.textSize,
      textDirection: textDirection ?? this.textDirection,
      textAlign: textAlign ?? this.textAlign,
      textColor: textColor ?? this.textColor,
      textWeight: textWeight ?? this.textWeight,
      overflow: overflow ?? this.overflow,
      textStyle: M.TextStyle(
        background: textStyle?.background,
        backgroundColor: textStyle?.backgroundColor,
        color: textStyle?.color ?? _color,
        debugLabel: textStyle?.debugLabel,
        decoration: textStyle?.decoration,
        decorationColor: textStyle?.decorationColor,
        decorationStyle: textStyle?.decorationStyle,
        decorationThickness: textStyle?.decorationThickness,
        fontFamily: textStyle?.fontFamily,
        fontFamilyFallback: textStyle?.fontFamilyFallback,
        fontFeatures: textStyle?.fontFeatures,
        fontSize: textStyle?.fontSize ?? _fontSize,
        fontWeight: textStyle?.fontWeight ?? _fontWeight,
        fontStyle: textStyle?.fontStyle,
        foreground: textStyle?.foreground,
        height: textStyle?.height,
        inherit: textStyle?.inherit ?? true,
        letterSpacing: textStyle?.letterSpacing,
        locale: textStyle?.locale,
        shadows: textStyle?.shadows,
        textBaseline: textStyle?.textBaseline,
        wordSpacing: textStyle?.wordSpacing,
      ),
    );
  }

  Text addSuffix(String suffix) {
    return Text(
      '$suffix$content',
      textColor: textColor,
      textSize: textSize,
      textWeight: textWeight,
      textAlign: textAlign,
      textDirection: textDirection,
      overflow: overflow,
      textStyle: textStyle,
    );
  }

  Text addPreffix(String preffix) {
    return Text(
      '$content$preffix',
      textColor: textColor,
      textSize: textSize,
      textWeight: textWeight,
      textAlign: textAlign,
      textDirection: textDirection,
      overflow: overflow,
      textStyle: textStyle,
    );
  }

  @override
  M.Widget build(M.BuildContext context) {
    return autoSize
        ? AutoSizeText(
            content,
            maxLines: maxLines,
            minFontSize: minFontSize ?? 10.0,
            textDirection: textDirection,
            textAlign: textAlign,
            overflow: overflow,
            style: _textStyle,
          )
        : M.Text(
            content,
            textDirection: textDirection,
            textAlign: textAlign,
            overflow: overflow,
            style: _textStyle,
          );
  }
}
