import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart' show firebaseReady;

class ContactService {
  const ContactService._();

  static Future<void> submitMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    await firebaseReady;
    await FirebaseFirestore.instance.collection('contact_messages').add({
      'name': name,
      'email': email,
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
