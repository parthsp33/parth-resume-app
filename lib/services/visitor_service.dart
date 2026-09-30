import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_resume_app/main.dart' show firebaseReady;

class VisitorService {
  Future<DocumentReference<Map<String, dynamic>>?> _tryGetRef() async {
    try {
      await firebaseReady;
      return FirebaseFirestore.instance
          .collection('site_stats')
          .doc('visitors');
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

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(ref);
        final current = snapshot.data()?['count'];
        transaction.set(ref, {'count': current is int ? current + 1 : 1});
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

    yield* ref.snapshots().map((snapshot) {
      final count = snapshot.data()?['count'];
      return count is int ? count : 0;
    }).handleError((Object e) {
      debugPrint('Visitor count stream error: $e');
    });
  }
}
