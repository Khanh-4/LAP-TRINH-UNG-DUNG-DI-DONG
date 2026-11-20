import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/auth_repository.dart';
import '../domain/app_user.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._repository) : _user = _repository.currentUser {
    _subscription = _repository.authStateChanges().listen(_onUserChanged);
  }

  static const String _genericError = 'Đã có lỗi xảy ra, vui lòng thử lại';

  final AuthRepository _repository;
  late final StreamSubscription<AppUser?> _subscription;

  AppUser? _user;
  bool _isLoading = false;
  String? _errorMessage;

  AppUser? get user => _user;
  bool get isSignedIn => _user != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Các hàm dưới trả về `true` nếu thành công; lỗi được lưu ở [errorMessage].
  Future<bool> signIn({required String email, required String password}) {
    return _run(() async {
      _user = await _repository.signInWithEmail(
        email: email.trim(),
        password: password,
      );
    });
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String displayName,
  }) {
    return _run(() async {
      _user = await _repository.signUpWithEmail(
        email: email.trim(),
        password: password,
        displayName: displayName.trim(),
      );
    });
  }

  Future<bool> sendPasswordReset(String email) =>
      _run(() => _repository.sendPasswordResetEmail(email.trim()));

  Future<void> signOut() async {
    await _repository.signOut();
    _onUserChanged(null);
  }

  void clearError() {
    if (_errorMessage == null) return;
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> _run(Future<void> Function() action) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await action();
      return true;
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      debugPrint('AuthController: lỗi không mong đợi: $e');
      _errorMessage = _genericError;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _onUserChanged(AppUser? user) {
    _user = user;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
