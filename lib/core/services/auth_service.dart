import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn();

  // ─── Google Sign-In ───────────────────────────────────────────

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _firebaseAuth
        .signInWithCredential(credential);
    return userCredential.user;
  }

  // ─── Apple Sign-In ────────────────────────────────────────────

  /// Generates a cryptographically secure random nonce.
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  /// Returns the SHA-256 hash of [input] as a hex string.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User?> signInWithApple() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider(
      'apple.com',
    ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);

    final UserCredential userCredential = await _firebaseAuth
        .signInWithCredential(oauthCredential);

    // Apple only provides name on first sign-in, so save it
    if (userCredential.user?.displayName == null ||
        userCredential.user!.displayName!.isEmpty) {
      final fullName = [
        appleCredential.givenName,
        appleCredential.familyName,
      ].where((n) => n != null && n.isNotEmpty).join(' ');

      if (fullName.isNotEmpty) {
        await userCredential.user?.updateDisplayName(fullName);
        await userCredential.user?.reload();
      }
    }

    return _firebaseAuth.currentUser;
  }

  // ─── Email / Password ─────────────────────────────────────────

  Future<User?> signInWithEmail(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<User?> registerWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.updateDisplayName(displayName);
    await userCredential.user?.reload();
    return _firebaseAuth.currentUser;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // ─── Common ───────────────────────────────────────────────────

  Future<void> signOut() async {
    await Future.wait([_googleSignIn.signOut(), _firebaseAuth.signOut()]);
  }

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
