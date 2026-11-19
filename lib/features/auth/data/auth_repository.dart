import '../domain/app_user.dart';

/// Giao diện truy cập xác thực. UI và controller chỉ phụ thuộc vào lớp này,
/// nên có thể đổi từ bản giả lập sang Firebase mà không sửa màn hình.
abstract interface class AuthRepository {
  AppUser? get currentUser;

  Stream<AppUser?> authStateChanges();

  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  });

  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}

/// Lỗi xác thực có thông báo thân thiện để hiển thị cho người dùng.
class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
