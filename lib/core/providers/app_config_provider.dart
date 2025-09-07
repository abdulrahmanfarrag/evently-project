import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String locale = "en";

  void changeTheme(ThemeMode newTheme) {
    themeMode = newTheme;
    notifyListeners();
  }

  void changeLocale(String locale) {
    this.locale = locale;
    notifyListeners();
  }
}
