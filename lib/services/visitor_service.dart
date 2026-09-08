import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_resume_app/main.dart' show firebaseReady;

class VisitorService {
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

        if (currentData is int) {
          return Transaction.success(currentData + 1);
        } else if (currentData is Map) {
          // Sometimes Firebase returns it as a map, handling safety
          return Transaction.success((currentData['count'] ?? 0) + 1);
        }

        return Transaction.success(1); // Fallback
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
      if (data is int) {
        return data;
      } else if (data is Map) {
        return (data['count'] ?? 0) as int;
      }
      return 0; // Default if null or unknown format
    });
  }
}
