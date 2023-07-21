// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class brightessSwitch with ChangeNotifier {
  String _background = "#303030";
  String _text = "#FFFFFF";
  bool _isDark = true;

  String get background => _background;

  String get text => _text;

  bool get isDark => _isDark;

  void switchDark() {
    _isDark = true;
    _background = "#303030";
    _text = "#FFFFFF";
    notifyListeners();
  }

  void switchLight() {
    _isDark = false;
    _background = "#FFFFFF";
    _text = "#333333";
    notifyListeners();
  }
}
