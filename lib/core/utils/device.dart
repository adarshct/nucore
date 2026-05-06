import 'package:flutter/material.dart';
import 'package:nucore_project/core/utils/page_navigator.dart';

abstract class Device {
  static double get width =>
      MediaQuery.of(NavigationService.context!).size.width;

  static double get height =>
      MediaQuery.of(NavigationService.context!).size.height;

  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: 15);
}
