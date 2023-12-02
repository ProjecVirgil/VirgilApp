// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class brightessSwitch with ChangeNotifier {
  String _background = "#1d1e27";
  String _text = "#dddddf";
  bool _isDark = true;

  String get background => _background;

  String get text => _text;

  bool get isDark => _isDark;

  void switchDark() {
    _isDark = true;
    _background = "#1d1e27";
    _text = "#dddddf";
    notifyListeners();
  }

  void switchLight() {
    _isDark = false;
    _background = "#dddddf";
    _text = "#1d1e27";
    notifyListeners();
  }
}
