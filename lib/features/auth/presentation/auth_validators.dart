import '../../../core/constants/app_constants.dart';

/// Validator dùng chung cho các form xác thực.
abstract final class AuthValidators {
  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Vui lòng nhập email';
    if (!email.contains('@')) return 'Email không hợp lệ';
    return null;
  }

  static String? password(String? value) {
    if ((value ?? '').length < AppConstants.minPasswordLength) {
      return 'Mật khẩu phải có ít nhất ${AppConstants.minPasswordLength} ký tự';
    }
    return null;
  }

  static String? displayName(String? value) =>
      (value?.trim() ?? '').isEmpty ? 'Vui lòng nhập tên' : null;
}
