import 'dart:async';

import '../../../core/constants/app_constants.dart';
import '../domain/app_user.dart';
import 'auth_repository.dart';

/// Bản giả lập trong bộ nhớ, dùng khi chưa nối Firebase và trong test.
class FakeAuthRepository implements AuthRepository {
  final StreamController<AppUser?> _changes =
      StreamController<AppUser?>.broadcast();
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
    if (!email.contains('@')) {
      throw const AuthException('Email không hợp lệ');
    }
    if (password.length < AppConstants.minPasswordLength) {
      throw const AuthException('Mật khẩu phải có ít nhất 6 ký tự');
    }
    final user = AppUser(id: 'local-$email', email: email);
    _setUser(user);
    return user;
  }

  @override
  Future<void> signOut() async => _setUser(null);

  void _setUser(AppUser? user) {
    _user = user;
    _changes.add(user);
  }
}
