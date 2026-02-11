import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  /// Google Sign-In
  Future<User?> signInWithGoogle() async {
    return await _authService.signInWithGoogle();
  }

  /// Apple Sign-In
  Future<User?> signInWithApple() async {
    return await _authService.signInWithApple();
  }

  /// Email/Password Sign-In
  Future<User?> signInWithEmail(String email, String password) async {
    return await _authService.signInWithEmail(email, password);
  }

  /// Email/Password Registration
  Future<User?> registerWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    return await _authService.registerWithEmail(email, password, displayName);
  }

  /// Password Reset
  Future<void> sendPasswordResetEmail(String email) async {
    await _authService.sendPasswordResetEmail(email);
  }

  /// Sign out from all providers
  Future<void> signOut() async {
    await _authService.signOut();
  }

  bool get isSignedIn => _authService.currentUser != null;
  User? get currentUser => _authService.currentUser;
  Stream<User?> get authStateChanges => _authService.authStateChanges;
}
