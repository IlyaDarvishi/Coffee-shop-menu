import 'package:flutter/material.dart';
import 'light_mode.dart';
import 'dark_mode.dart';

/// ارائه‌دهنده تم برای مدیریت حالت روشن و تاریک برنامه
class ThemeProvider extends ChangeNotifier {
  /// داده تم فعلی
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  /// آیا تم فعلی حالت تاریک است؟
  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  /// تغییر حالت تم بین روشن و تاریک
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
}
