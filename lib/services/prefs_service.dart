import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Small settings kept in the browser (localStorage on web).
///
/// Every call is wrapped in try/catch: storage can be blocked, for example in
/// some private browsing modes, and that must never break the page.
class PrefsService {
  const PrefsService._();

  static const _themeKey = 'theme_mode';
  static const _lastVisitKey = 'last_visit_day';

  /// The theme the visitor picked last time, or null if they never picked
  /// one. Null means the app follows the system theme.
  static Future<ThemeMode?> loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return switch (prefs.getString(_themeKey)) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => null,
      };
    } catch (e) {
      debugPrint('Could not read theme preference: $e');
      return null;
    }
  }

  static Future<void> saveThemeMode(ThemeMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, mode.name);
    } catch (e) {
      debugPrint('Could not save theme preference: $e');
    }
  }

  /// Returns true the first time it is called on a given day, and saves the
  /// day so later calls on the same day return false.
  static Future<bool> isFirstVisitToday() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now();
      final today = '${now.year}-${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')}';
      if (prefs.getString(_lastVisitKey) == today) return false;
      await prefs.setString(_lastVisitKey, today);
      return true;
    } catch (e) {
      debugPrint('Could not read last visit day: $e');
      // Storage is blocked, so we cannot tell. Count the visit.
      return true;
    }
  }
}
