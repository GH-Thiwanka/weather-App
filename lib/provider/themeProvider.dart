import 'package:flutter/material.dart';
import 'package:weather/service/themePersistance.dart';
import 'package:weather/utils/thems.dart';

class Themeprovider extends ChangeNotifier {
  ThemeData _themeData = TheamsModeData().lightMode;

  Themeprovider() {
    _loadTheme();
  }

  final Themepersistance _themepersistance = Themepersistance();

  //getter for get values
  ThemeData get getThemeData => _themeData;

  //setter for updet value
  set setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  //load the theme from shared pref
  Future<void> _loadTheme() async {
    bool isDark = await _themepersistance.loadTheme();
    setThemeData = isDark
        ? TheamsModeData().darkMode
        : TheamsModeData().lightMode;
  }

  //toggle theme
  Future<void> toggleTheme(bool isDark) async {
    setThemeData = isDark
        ? TheamsModeData().darkMode
        : TheamsModeData().lightMode;
    await _themepersistance.storeTheme(isDark);
  }
}
