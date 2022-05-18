import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:machinavision/tool_kit.dart' as T;
// import 'package:machinavision/ui_kit.dart' as U;
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';

abstract class Utilities {
//
  static const appName = 'machinavision';

  static const appVersion = // '(local)0.2.7',
      '0.9.3(dev)';
  // '(stb)0.8.0'

  static const isProduct = false;

  static const isRelease = kReleaseMode;

  static const isRahbar = false;

  static String get platform => isWeb ? 'web' : Platform.operatingSystem;

  static bool get isWeb => kIsWeb;

  static bool get isDesktop => isWeb
      ? false
      : Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  static bool get isMobile =>
      isWeb ? false : Platform.isIOS || Platform.isAndroid;

  static initAndroid() {
    setMobileSysColor();
  }

  static setMobileSysColor() {
    if (T.Utilities.isMobile) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: T.Colors.primary,
          systemNavigationBarColor: T.Colors.primary,
        ),
      );
    }
  }

  static scrollList(GlobalKey key) => Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 400),
      );

  ///0 < fraction < 1
  static Size viewPortSize(BuildContext context, {double? fraction}) {
    var _fraction = fraction ?? 1;
    final mediaQuerySize = MediaQuery.of(context).size;
    final height = mediaQuerySize.height;
    final width = mediaQuerySize.width;
    return Size(width * _fraction, height * _fraction);
  }

  static double bodyHeight(BuildContext context, [AppBar? appBarWidget]) {
    final mediaQuery = MediaQuery.of(context);
    return appBarWidget != null
        ? mediaQuery.size.height -
            mediaQuery.padding.top -
            appBarWidget.preferredSize.height
        : mediaQuery.size.height - mediaQuery.padding.top;
  }

  static double bodyWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static PageRouteBuilder animatedPageRoute(
    Widget screen,
    RouteSettings settings,
  ) {
    return PageRouteBuilder(
      pageBuilder: (context, anim1, anim2) => screen,
      transitionsBuilder: (context, anim1, anim2, child) => FadeTransition(
        opacity: anim1,
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 400),
      settings: settings,
    );
  }

  static showModal({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = false,
    Duration transitionDuration = const Duration(milliseconds: 150),
  }) {
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: barrierDismissible,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      barrierColor: T.Colors.modalBarrier,
      transitionDuration: transitionDuration,
      transitionBuilder: (ctx, anim1, anim2, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8,
            sigmaY: 8,
          ),
          child: FadeTransition(
            child: child,
            opacity: anim1,
          ),
        );
      },
    );
  }

  static void showToolTip(GlobalKey key) {
    final dynamic _toolTip = key.currentState;
    _toolTip?.ensureTooltipVisible();
  }

  static Map<String, dynamic>? nullKiller(Map<String, dynamic>? dy) {
    Map<String, dynamic>? temp = {};

    dy?.forEach(
      (key, value) {
        if (value != null) {
          if (value == '') {
            temp[key] = null;
          } else if (value.runtimeType == Map) {
            temp[key] = nullKiller(value);
          } else
            temp[key] = value;
        }
      },
    );

    return temp;
  }

  static Map<String, dynamic>? qpNullKiller(Map<String, dynamic>? dy) {
    Map<String, dynamic>? temp = {};

    dy?.forEach(
      (key, value) {
        if (value != null && value != '') {
          if (value.runtimeType == Map) {
            temp[key] = qpNullKiller(value);
          } else
            temp[key] = value;
        }
      },
    );

    return temp;
  }

  static String charInjector(
    String s,
    String char,
    int loopIndex, {
    bool loop = false,
  }) {
    var text = s.split('').reversed.join();
    if (!loop) {
      if (text.length < loopIndex) {
        return s;
      }
      var before = text.substring(0, loopIndex);
      var after = text.substring(loopIndex, text.length);
      return before + char + after;
    } else {
      if (loopIndex == 0) {
        return s;
      }
      var a = StringBuffer();
      for (var i = 0; i < text.length; i++) {
        if (i != 0 && i % loopIndex == 0) {
          a.write(char);
        }
        a.write(String.fromCharCode(text.runes.elementAt(i)));
      }
      return a.toString().split('').reversed.join();
    }
  }

  static bool clockbaseEnc(keyA, keyB) {
    var now = DateTime.now();
    int encA;
    int encB;
    if (now.hour.toString().length == 2) {
      var a = int.parse(now.hour.toString().substring(0, 1));
      var b = int.parse(now.hour.toString().substring(1, 2));
      var temp = (a - b).abs();
      encA = temp == 0 ? 2 : temp;
    } else {
      var temp = int.parse(now.hour.toString());
      encA = temp == 0 ? 2 : temp;
    }
    if (now.minute.toString().length == 2) {
      var a = int.parse(now.minute.toString().substring(0, 1));
      var b = int.parse(now.minute.toString().substring(1, 2));
      var temp = (a - b).abs();
      encB = temp == 0 ? 2 : temp;
    } else {
      var temp = int.parse(now.minute.toString());
      encB = temp == 0 ? 2 : temp;
    }

    return encA == keyA && encB == keyB;
  }

  static void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
