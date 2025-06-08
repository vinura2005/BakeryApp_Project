import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_initialization_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Ensure Firebase is properly initialized
      await FirebaseInitializationService.ensureInitialized();

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } on TypeError catch (e) {
      throw 'Configuration error. Please restart the app and try again.';
    } catch (e) {
      if (e.toString().contains('PigeonUserDetails') ||
          e.toString().contains('type cast') ||
          e.toString().contains('List<Object?>')) {
        throw 'Authentication service error. Please restart the app and try again.';
      }

      if (e.toString().contains('Exception') ||
          e.toString().contains('Error')) {
        throw 'An unexpected error occurred during registration. Please try again.';
      }

      rethrow;
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e.toString().contains('Exception') ||
          e.toString().contains('Error')) {
        throw 'An unexpected error occurred during login. Please try again.';
      }
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw 'Error signing out. Please try again.';
    }
  }

  // Reset password
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email address. Please check your email or create a new account.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email address. Please use a different email or try logging in.';
      case 'weak-password':
        return 'Password is too weak. Please use at least 6 characters with a mix of letters and numbers.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support for assistance.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please wait a moment and try again.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled. Please contact support.';
      case 'invalid-credential':
        return 'The email or password you entered is incorrect. Please check your credentials and try again.';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please try again.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please try again.';
      case 'credential-already-in-use':
        return 'This account is already associated with another user.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      default:
        if (e.message?.contains('RecaptchaAction') == true ||
            e.message?.contains('recaptcha') == true) {
          return 'Security verification failed. Please check your email and password and try again.';
        }
        if (e.message?.contains('credential') == true) {
          return 'The email or password you entered is incorrect. Please check your credentials and try again.';
        }
        if (e.message?.contains('network') == true) {
          return 'Network error. Please check your internet connection and try again.';
        }
        return 'Login failed. Please check your email and password and try again.';
    }
  }

  bool get isSignedIn => currentUser != null;
  String? get userEmail => currentUser?.email;
  String? get userId => currentUser?.uid;
}
