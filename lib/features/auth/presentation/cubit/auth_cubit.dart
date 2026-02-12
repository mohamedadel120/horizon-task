import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:task/core/base/cubit/base_cubit.dart';
import 'package:task/features/auth/data/models/app_user_model.dart';
import 'package:task/features/auth/data/repositories/auth_repository.dart';
import 'package:task/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState());

  // Constants for endpoints
  static const String endpointLogin = 'login';
  static const String endpointRegister = 'register';
  static const String endpointForgotPassword = 'forgot_password';
  static const String endpointSignOut = 'sign_out';

  // ─── Google ───────────────────────────────────────────────────

  Future<void> signInWithGoogle() async {
    startOperation(endpointLogin);
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        successOperation(
          endpointLogin,
          data: AppUserModel.fromFirebaseUser(user),
        );
      } else {
        failOperation(endpointLogin, "Sign in cancelled");
      }
    } catch (e) {
      failOperation(endpointLogin, _friendlyError(e));
    }
  }

  // ─── Apple ────────────────────────────────────────────────────

  Future<void> signInWithApple() async {
    startOperation(endpointLogin);
    try {
      final user = await _authRepository.signInWithApple();
      if (user != null) {
        successOperation(
          endpointLogin,
          data: AppUserModel.fromFirebaseUser(user),
        );
      } else {
        failOperation(endpointLogin, "Sign in cancelled");
      }
    } catch (e) {
      failOperation(endpointLogin, _friendlyAppleError(e));
    }
  }

  // ─── Email / Password ─────────────────────────────────────────

  Future<void> signInWithEmail(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      failOperation(endpointLogin, 'Please fill in all fields.');
      return;
    }
    startOperation(endpointLogin);
    try {
      final user = await _authRepository.signInWithEmail(email, password);
      if (user != null) {
        successOperation(
          endpointLogin,
          data: AppUserModel.fromFirebaseUser(user),
        );
      } else {
        failOperation(endpointLogin, 'Sign-in failed. Please try again.');
      }
    } catch (e) {
      failOperation(endpointLogin, _friendlyError(e));
    }
  }

  Future<void> registerWithEmail(
    String name,
    String email,
    String password,
  ) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      failOperation(endpointRegister, 'Please fill in all fields.');
      return;
    }
    startOperation(endpointRegister);
    try {
      final user = await _authRepository.registerWithEmail(
        email,
        password,
        name,
      );
      if (user != null) {
        successOperation(
          endpointRegister,
          data: AppUserModel.fromFirebaseUser(user),
        );
      } else {
        failOperation(
          endpointRegister,
          'Registration failed. Please try again.',
        );
      }
    } catch (e) {
      failOperation(endpointRegister, _friendlyError(e));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      failOperation(endpointForgotPassword, 'Please enter your email address.');
      return;
    }
    startOperation(endpointForgotPassword);
    try {
      await _authRepository.sendPasswordResetEmail(email);
      successOperation(endpointForgotPassword, data: null);
    } catch (e) {
      failOperation(endpointForgotPassword, _friendlyError(e));
    }
  }

  // ─── Sign Out ─────────────────────────────────────────────────

  Future<void> signOut() async {
    startOperation(endpointSignOut);
    try {
      await _authRepository.signOut();
      successOperation(endpointSignOut, data: null);
    } catch (e) {
      failOperation(endpointSignOut, _friendlyError(e));
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────

  /// User-friendly message for Sign in with Apple (handles error 1000).
  String _friendlyAppleError(dynamic e) {
    if (e is SignInWithAppleAuthorizationException) {
      if (e.code == AuthorizationErrorCode.unknown) {
        return "Sign in with Apple isn't available here. ";
            // "Try on a real device, or use Email / Google below to test. "
            // "On simulator: sign in to Settings → [your name] with an Apple ID and retry, or use Email/Google.";
      }
      if (e.code == AuthorizationErrorCode.canceled) {
        return 'Sign in cancelled';
      }
      if (e.code == AuthorizationErrorCode.notHandled) {
        return 'Sign in was not completed. Please try again.';
      }
    }
    return _friendlyError(e);
  }

  String _friendlyError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No account found with this email.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'weak-password':
          return 'Password is too weak. Use at least 6 characters.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        case 'invalid-credential':
          return 'Invalid email or password.';
        default:
          return e.message ?? 'Authentication failed.';
      }
    }
    return e.toString();
  }
}
