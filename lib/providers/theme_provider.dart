import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  ThemeMode _themeMode = ThemeMode.system;
  bool _initialized = false;

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;
  bool get initialized => _initialized;

  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeMode = prefs.getString(_themeKey);
      if (savedThemeMode != null) {
        _themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == savedThemeMode,
          orElse: () => ThemeMode.system,
        );
      }
    } catch (e) {
      debugPrint('Error loading theme mode: $e');
    } finally {
      _initialized = true;
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, mode.toString());
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }
}
