import 'package:flutter/material.dart';
// import 'package:digihaseb/tool_kit.dart' as T;

enum AppTheme { light, dark, system }

abstract class Colors {
//
  // 100% — FF / 95% — F2 / 90% — E6 / 85% — D9 / 80% — CC / 75% — BF / 70% — B3
  //  65% — A6 / 60% — 99 / 55% — 8C / 50% — 80 / 45% — 73 / 40% — 66 / 35% — 59
  //  30% — 4D / 25% — 40 / 20% — 33 / 15% — 26 / 10% — 1A /  5% — 0D /  0% — 00

  static AppTheme get appTheme => AppTheme.light;

  static bool get themeIsLight => true;
  static bool get themeIsDark => false;

  static const List<Color> backgrounds = [
    Color(0xFFEAEAEA),
    Color(0xFF323D4C),
  ];
  static Color get background => backgrounds[appTheme.index];

  static const List<Color> backgrounds2 = [
    Color(0xFFEBF1FF),
    Color(0xFF323D4C)
  ];
  static Color get background2 => backgrounds2[appTheme.index];

  static const List<Color> whites = [
    Color(0xFFFFFFFF),
    Color(0xFFFFFFFF),
  ];
  static Color get white => whites[appTheme.index];

  static const List<Color> shadows = [
    Color(0x26323D4C),
    Color(0x4D000000),
    // Color(0x40EBF1FF),
  ];
  static Color get shadow => shadows[appTheme.index];

  static const List<Color> disabledWhites = [
    Color(0xDCFFFFFF),
    Color(0xDCFFFFFF),
  ]; //86%
  static Color get disabledWhite => disabledWhites[appTheme.index];

  static const List<Color> primaries = [
    Color(0xFF028A99),
    Color(0xFF1F2B3D),
  ];
  static Color get primary => primaries[appTheme.index];

  static const List<Color> disabledPrimaries = [
    Color(0x7F028A99), //50%
    Color(0x7F1F2B3D) //50%
  ];
  static Color get disabledPrimary => disabledPrimaries[appTheme.index];

  static const List<Color> primaries2 = [
    Color(0xFF213468),
    Color(0xFFE4E4E4),
  ];
  static Color get primary2 => primaries2[appTheme.index];

  static const List<Color> disabledPrimaries2 = [
    Color(0x7F213468),
    Color(0x7FE4E4E4),
  ];
  static Color get disabledPrimary2 => disabledPrimaries2[appTheme.index];

  static const List<Color> secondaries = [
    Color(0xFF03C7C3),
    Color(0xFF7DC7C4),
  ];
  static Color get secondary => secondaries[appTheme.index];

  static const List<Color> disabledSecondaries = [
    Color(0x7F03C7C3),
    Color(0x7F7DC7C4),
  ];
  static Color get disabledSecondary => disabledSecondaries[appTheme.index];

  static const List<Color> notifBackgrounds = [
    Color(0xE6FFFFFF),
    Color(0xE6E4E4E4),
  ];
  static Color get notifBackground => notifBackgrounds[appTheme.index];

  static const Color successPrimary = Color(0xFF73C45E);
  static const Color successSecondary = Color(0x7F73C45E); //50%
  static const Color warningPrimary = Color(0xFFFF7536); //100%
  static const Color warningSecondary = Color(0x7FFF7536); //50%
  static const Color errorPrimary = Color(0xFFF54E4E); //100%
  static const Color errorSecondary = Color(0x7FF54E4E); //50%

  static const List<Color> iconPrimaries = [
    Color(0xFF028A99),
    Color(0xFF7DC7C4),
  ];
  static Color get iconPrimary => iconPrimaries[appTheme.index];

  static const List<Color> iconPrimaries2 = [
    Color(0xFF213468),
    Color(0xFF7DC7C4),
  ];
  static Color get iconPrimary2 => iconPrimaries2[appTheme.index];

  static const List<Color> iconSecondaries = [
    Color(0xFF03C7C3),
    Color(0xFF7DC7C4),
  ];
  static Color get iconSecondary => iconSecondaries[appTheme.index];

  static const List<Color> mainPanelHeaders = [
    Color(0xFFFFFFFF),
    Color(0xFF1F2B3D),
  ];
  static const List<Color> mainPanelMobileHeaders = [
    Color(0xFFFFFFFF), //100%
    Color(0x0DFFFFFF), //5%
  ];
  // static Color get mainPanelHeader => T.Utilities.isDesktop
  //     ? mainPanelHeaders[appTheme.index]
  //     : mainPanelMobileHeaders[appTheme.index];

  static const List<Color> headers = [
    Color(0x07213468), // 3%
    Color(0x07E4E4E4), //3%
  ];
  static Color get header => headers[appTheme.index];

  static const List<Color> headerBoxes = [
    Color(0xFFFFFFFF), //100%
    Color(0x7FE4E4E4), //50%
  ];
  static Color get headerBox => headerBoxes[appTheme.index];

  static const List<Color> panelCards = [
    Color(0xFFFFFFFF),
    Color(0x33FFFFFF),
  ];
  static Color get panelCard => panelCards[appTheme.index];

  static const List<Color> modalBarriers = [
    Color(0x19000000), //10%
    Color(0x19FFFFFF), //4%
  ];
  static Color get modalBarrier => modalBarriers[appTheme.index];

  static const List<Color> dividers = [
    Color(0x7F213468),
    Color(0x7FE4E4E4)
  ]; // 50%
  static Color get divider => dividers[appTheme.index];

  static const List<Color> sideMenus = [
    Color(0xB2FFFFFF), //70%
    Color(0x19FFFFFF),
  ];
  static Color get sideMenu => sideMenus[appTheme.index];

  static const List<Color> sideMenuShapes = [
    Color(0xFFFFFFFF), //70%
    Color(0x26FFFFFF), //15%
  ];
  static Color get sideMenuShape => sideMenuShapes[appTheme.index];

  static const List<Color> tableHeaders = [
    Color(0x0A000000),
    Color(0x0A000000),
    // Color(0x0AFFFFFF),
  ];
  static Color get tableHeader => tableHeaders[appTheme.index];

  static const List<Color> tableDividers = [
    Color(0x26213468), //15%
    Color(0x267DC7C4), //15%
  ];
  static Color get tableDivider => tableDividers[appTheme.index];

  static const List<Color> tableRows = [
    Color(0x7FFFFFFF), //50%
    Color(0x05FFFFFF), //1%
  ];
  static Color get tableRow => tableRows[appTheme.index];

  static const List<Color> textInputs = [
    // Color(0x7FFFFFFF),
    Color(0x4DFFFFFF), //30%
    Color(0x10FFFFFF), //2%
  ];
  static Color get textInput => textInputs[appTheme.index];

  static const List<Color> subRouteTexts = [
    Color(0xFF028A99),
    Color(0xFF7DC7C4),
  ];
  static Color get subRouteText => subRouteTexts[appTheme.index];

  static const List<Color> disabledSubRouteTexts = [
    Color(0x7F028A99),
    Color(0x7F7DC7C4),
  ];
  static Color get disabledSubRouteText =>
      disabledSubRouteTexts[appTheme.index];

  static const List<Color> modalTabs = [
    Color(0xB2FFFFFF), //70%
    Color(0x26FFFFFF), //15%
  ];
  static Color get modalTab => modalTabs[appTheme.index];

  static const List<Color> disabledModalTabs = [
    Color(0x66FFFFFF), //40%
    Color(0x0DFFFFFF), //5%
  ];
  static Color get disabledModalTab => disabledModalTabs[appTheme.index];

  static const List<Color> disabledTexts = [
    Color(0x61000000),
    Color(0xB2FFFFFF),
  ];
  static Color get disabledText => disabledTexts[appTheme.index];

  static const List<Color> invoiceEditRows = [
    Color(0xD9FFFFFF), //85%
    Color(0x10FFFFFF), //2%
  ];
  static Color get invoiceEditRow => invoiceEditRows[appTheme.index];

  static const List<Color> disabledInvoiceEditRows = [
    Color(0x7FFFFFFF), //50%
    Color(0x05FFFFFF), //1%
  ];
  static Color get disabledInvoiceEditRow =>
      disabledInvoiceEditRows[appTheme.index];

  static const List<Color> invoiceEditRowSubmits = [
    Color(0xD9FFFFFF), //85%
    // Color(0xD97DC7C4), //85%
    Color(0x10FFFFFF), //2%
  ];
  static Color get invoiceEditRowSubmit =>
      invoiceEditRowSubmits[appTheme.index];

  static const List<Color> invoiceEditRowBorders = [
    Color(0xD9FFFFFF), //85%
    Color(0x1AE4E4E4), //20%
  ];
  static Color get invoiceEditRowBorder =>
      invoiceEditRowBorders[appTheme.index];

  static const List<Color> navigationRails = [
    Color(0x26ffffff), //15%
    Color(0x0Dffffff), //5%
  ];
  static Color get navigationRail => navigationRails[appTheme.index];

  static const Color deleteWarning = Color(0xffeb746e);
  static const Color errorWarning = Color(0xffcc2347);

  static Color hexColor(String hex, int opacity) {
    if (hex.startsWith('#')) {
      var alpha = (255 * (opacity / 100)).toInt().toRadixString(16);
      return hex.length == 7
          ? Color(int.parse(hex.replaceAll('#', '0x$alpha')))
          : throw ('hex color code must be 7 character');
    } else
      throw ('hex color code must start with \'#\'');
  }
}
