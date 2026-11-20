import 'dart:async';

import '../../../core/constants/app_constants.dart';
import '../domain/app_user.dart';
import 'auth_repository.dart';

/// Bản giả lập trong bộ nhớ, dùng khi chưa cấu hình Firebase và trong test.
class FakeAuthRepository implements AuthRepository {
  final StreamController<AppUser?> _changes =
      StreamController<AppUser?>.broadcast();
  final Map<String, String> _displayNames = {};
  AppUser? _user;

  @override
  AppUser? get currentUser => _user;

  @override
  Stream<AppUser?> authStateChanges() => _changes.stream;

  @override
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _validate(email, password);
    final user = AppUser(
      id: 'local-$email',
      email: email,
      displayName: _displayNames[email],
    );
    _setUser(user);
    return user;
  }

  @override
  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    _validate(email, password);
    _displayNames[email] = displayName;
    final user = AppUser(
      id: 'local-$email',
      email: email,
      displayName: displayName,
    );
    _setUser(user);
    return user;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    if (!email.contains('@')) throw const AuthException('Email không hợp lệ');
  }

  @override
  Future<void> signOut() async => _setUser(null);

  static void _validate(String email, String password) {
    if (!email.contains('@')) {
      throw const AuthException('Email không hợp lệ');
    }
    if (password.length < AppConstants.minPasswordLength) {
      throw const AuthException('Mật khẩu phải có ít nhất 6 ký tự');
    }
  }

  void _setUser(AppUser? user) {
    _user = user;
    _changes.add(user);
  }
}
