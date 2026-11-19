import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/auth_repository.dart';
import '../domain/app_user.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._repository) : _user = _repository.currentUser {
    _subscription = _repository.authStateChanges().listen(_onUserChanged);
  }

  final AuthRepository _repository;
  late final StreamSubscription<AppUser?> _subscription;

  AppUser? _user;
  bool _isLoading = false;
  String? _errorMessage;

  AppUser? get user => _user;
  bool get isSignedIn => _user != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Trả về `true` nếu đăng nhập thành công; lỗi được lưu ở [errorMessage].
  Future<bool> signIn({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _user = await _repository.signInWithEmail(
        email: email.trim(),
        password: password,
      );
      return true;
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (_) {
      _errorMessage = 'Đã có lỗi xảy ra, vui lòng thử lại';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    _onUserChanged(null);
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
