
import 'package:flutter/material.dart';

extension ResponsiveUtil on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get defaultLargeHotizontalPadding => screenSize.width / 5;

  bool get isPortrait => screenSize.width < screenSize.height;

  double get responsiveWidth => isPortrait ? screenSize.width : screenSize.height;

  double get responsiveHeight => isPortrait ? screenSize.height : screenSize.width;

  bool get isLarge => responsiveWidth > 600;

  bool get isMedium => responsiveWidth > 380 && responsiveWidth < 600;

  bool get isSmall => responsiveWidth < 380;

  bool get isLandscape => screenSize.width > screenSize.height;

  bool get isXLarge => responsiveWidth > 1200;

  bool get isXSmall => responsiveWidth < 800;
}

extension ResponsiveUtilState on State {
  bool get isLarge => context.isLarge;

  bool get isMedium => context.isMedium;

  bool get isSmall => context.isSmall;

  bool get isPortrait => context.isPortrait;

  bool get isLandscape => context.isLandscape;

  bool get isXLarge => context.isXLarge;

  bool get isXSmall => context.isXSmall;
}
