import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_resume_app/services/prefs_service.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('No saved theme means follow the system', () async {
    expect(await PrefsService.loadThemeMode(), isNull);
  });

  test('Saved theme is read back', () async {
    await PrefsService.saveThemeMode(ThemeMode.light);
    expect(await PrefsService.loadThemeMode(), ThemeMode.light);

    await PrefsService.saveThemeMode(ThemeMode.dark);
    expect(await PrefsService.loadThemeMode(), ThemeMode.dark);
  });

  test('A visit is counted only once per day', () async {
    expect(await PrefsService.isFirstVisitToday(), isTrue);
    expect(await PrefsService.isFirstVisitToday(), isFalse);
  });

  test('A visit on a new day is counted again', () async {
    SharedPreferences.setMockInitialValues({'last_visit_day': '2000-01-01'});
    expect(await PrefsService.isFirstVisitToday(), isTrue);
  });
}
