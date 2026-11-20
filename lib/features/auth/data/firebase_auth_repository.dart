import 'package:firebase_auth/firebase_auth.dart';

import '../domain/app_user.dart';
import 'auth_error_messages.dart';
import 'auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  @override
  AppUser? get currentUser => _toAppUser(_auth.currentUser);

  @override
  Stream<AppUser?> authStateChanges() =>
      _auth.authStateChanges().map(_toAppUser);

  @override
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _requireUser(credential.user);
    });
  }

  @override
  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) {
    return _guard(() async {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      await user?.updateDisplayName(displayName);
      await user?.reload();
      return _requireUser(_auth.currentUser);
    });
  }

  @override
  Future<void> sendPasswordResetEmail(String email) =>
      _guard(() => _auth.sendPasswordResetEmail(email: email));

  @override
  Future<void> signOut() => _auth.signOut();

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (e) {
      throw AuthException(authErrorMessage(e.code));
    }
  }

  static AppUser _requireUser(User? user) {
    final appUser = _toAppUser(user);
    if (appUser == null) {
      throw const AuthException('Không lấy được thông tin tài khoản');
    }
    return appUser;
  }

  static AppUser? _toAppUser(User? user) => user == null
      ? null
      : AppUser(
          id: user.uid,
          email: user.email ?? '',
          displayName: user.displayName,
        );
}
