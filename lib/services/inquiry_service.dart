import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/inquiry_sheet_config.dart';

/// Result of attempting to persist an inquiry.
class InquirySaveResult {
  /// `null` if no Google Sheet webhook is configured; otherwise whether the POST succeeded.
  final bool? sheetSaved;

  const InquirySaveResult({
    this.sheetSaved,
  });
}

class InquiryPayload {
  final String firstName;
  final String lastName;
  final String email;
  final String projectType;
  final String? budgetRange;
  final String message;

  const InquiryPayload({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.projectType,
    this.budgetRange,
    required this.message,
  });

  Map<String, dynamic> toSheetJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'projectType': projectType,
        'budgetRange': budgetRange ?? '',
        'message': message,
      };
}

class InquiryService {
  Future<InquirySaveResult> saveInquiry(InquiryPayload payload) async {
    final sheetSaved = await _trySaveToSheet(payload);
    return InquirySaveResult(
      sheetSaved: sheetSaved,
    );
  }

  /// Returns `null` if webhook not configured; `true`/`false` for success/failure.
  Future<bool?> _trySaveToSheet(InquiryPayload payload) async {
    final url = InquirySheetConfig.webhookUrl;
    if (url == null || url.trim().isEmpty) return null;

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode(payload.toSheetJson()),
      );

      if (res.statusCode < 200 || res.statusCode >= 300) {
        debugPrint('Sheet webhook failed: ${res.statusCode} ${res.body}');
        return false;
      }
      return true;
    } catch (e) {
      debugPrint('Failed to save inquiry to Sheet: $e');
      return false;
    }
  }
}

