import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseInitializationService {
  static bool _isInitialized = false;

  static Future<void> ensureInitialized() async {
    if (!_isInitialized) {
      try {
        await Future.delayed(const Duration(milliseconds: 200));

        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp();
        }

        FirebaseAuth.instance;
        _isInitialized = true;
      } catch (e) {
        rethrow;
      }
    }
  }

  static void reset() {
    _isInitialized = false;
  }
}
