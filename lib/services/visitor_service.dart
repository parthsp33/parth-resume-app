import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_resume_app/main.dart' show firebaseReady;

class VisitorService {
  /// Reads a count out of whatever the database hands back.
  ///
  /// Realtime Database can return an int, a double, or a string depending on
  /// how the value was written. A plain `as int` throws on the last two, and
  /// inside a stream map that error escapes to the listener.
  static int _toCount(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  /// Waits for Firebase to finish starting up, then hands back the counter
  /// reference. Returns null when Firebase is not available, for example in
  /// widget tests.
  Future<DatabaseReference?> _tryGetRef() async {
    try {
      await firebaseReady;
      return FirebaseDatabase.instance.ref('visitor_count');
    } catch (e) {
      debugPrint('VisitorService not available: $e');
      return null;
    }
  }

  /// Safely increments the visitor count by 1 using a transaction.
  Future<void> incrementVisitorCount() async {
    try {
      final ref = await _tryGetRef();
      if (ref == null) return;

      await ref.runTransaction((Object? currentData) {
        if (currentData == null) {
          return Transaction.success(1); // Initialize if it doesn't exist
        }

        // Sometimes Firebase returns the value wrapped in a map.
        final current = currentData is Map
            ? _toCount(currentData['count'])
            : _toCount(currentData);

        return Transaction.success(current + 1);
      });
    } catch (e) {
      debugPrint('Error incrementing visitor count: $e');
    }
  }

  /// Returns a stream of the current visitor count. The stream stays empty
  /// until Firebase is ready, so the counter simply does not show up yet.
  Stream<int> getVisitorCountStream() async* {
    final ref = await _tryGetRef();
    if (ref == null) return;

    yield* ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data is Map) return _toCount(data['count']);
      return _toCount(data);
    }).handleError((Object e) {
      debugPrint('Visitor count stream error: $e');
    });
  }
}
