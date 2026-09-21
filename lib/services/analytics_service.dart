import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import '../main.dart' show firebaseReady;

class AnalyticsService {
  const AnalyticsService._();

  static Future<void> _log(
    String name, [
    Map<String, Object>? parameters,
  ]) async {
    try {
      await firebaseReady;
      await FirebaseAnalytics.instance.logEvent(
        name: name,
        parameters: parameters,
      );
    } catch (error) {
      debugPrint('Analytics event failed ($name): $error');
    }
  }

  static void logPortfolioView() => _log('portfolio_view');

  static void logContactClick(String method) =>
      _log('contact_click', {'method': method});

  static void logExternalLink(String destination) =>
      _log('external_link_click', {'destination': destination});

  static void logThemeToggle(String theme) =>
      _log('theme_toggle', {'theme': theme});
}
