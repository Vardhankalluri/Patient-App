import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  /// Get current theme mode
  ThemeMode getThemeMode() {
    return _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  }

  /// Load theme status from GetStorage
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  /// Save theme status to GetStorage
  void saveThemeMode(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch between light and dark mode
  void switchTheme() {
    bool isDark = _loadThemeFromBox();
    Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isDark);
  }
}
