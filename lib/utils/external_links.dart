import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/resume_data.dart';

/// One place that owns opening things outside the app.
///
/// Every call site used to do "check canLaunchUrl, launch if true, silently do
/// nothing if false", with no try/catch. On web `canLaunchUrl` is unreliable
/// for several schemes and `launchUrl` can throw when a popup is blocked, so a
/// dead click was a realistic outcome with no feedback at all.
class ExternalLinks {
  const ExternalLinks._();

  /// Gmail's web compose window, with the query properly encoded.
  ///
  /// The old inline version pasted the subject straight into the URL, so the
  /// spaces in it were never escaped.
  static Uri gmailCompose({
    String? to,
    String subject = 'Contact from Website',
    String body = 'Hello',
  }) {
    return Uri.https('mail.google.com', '/mail/', {
      'view': 'cm',
      'fs': '1',
      'to': to ?? ResumeData.email,
      'su': subject,
      'body': body,
    });
  }

  static Uri phone(String number) =>
      Uri(scheme: 'tel', path: number.replaceAll(' ', ''));

  /// Opens [uri]. Returns false when it could not be opened, so the caller can
  /// tell the visitor instead of leaving them looking at a dead control.
  static Future<bool> open(Uri uri) async {
    try {
      if (!await canLaunchUrl(uri)) {
        // Not fatal on web: canLaunchUrl is often wrong there, so still try.
        debugPrint('canLaunchUrl said no for $uri, attempting anyway');
      }
      return await launchUrl(uri, mode: LaunchMode.platformDefault);
    } catch (e) {
      debugPrint('Could not open $uri: $e');
      return false;
    }
  }

  /// [open], but shows a short message when it fails.
  ///
  /// Safe to call from an async tap handler: it re-checks that the widget is
  /// still mounted before touching the messenger.
  static Future<void> openOrNotify(BuildContext context, Uri uri) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final opened = await open(uri);
    if (opened || messenger == null) return;

    messenger.showSnackBar(
      SnackBar(
        content: Text('Could not open $uri'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
