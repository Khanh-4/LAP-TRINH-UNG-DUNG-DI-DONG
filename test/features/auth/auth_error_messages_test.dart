import 'package:expense_ai/features/auth/data/auth_error_messages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('wrong credentials share one message so emails are not enumerable', () {
    const expected = 'Email hoặc mật khẩu không đúng';
    expect(authErrorMessage('user-not-found'), expected);
    expect(authErrorMessage('wrong-password'), expected);
    expect(authErrorMessage('invalid-credential'), expected);
  });

  test('maps known codes to Vietnamese messages', () {
    expect(
      authErrorMessage('email-already-in-use'),
      'Email này đã được đăng ký',
    );
    expect(authErrorMessage('network-request-failed'), 'Không có kết nối mạng');
  });

  test('unknown code falls back to generic message', () {
    expect(
      authErrorMessage('something-new'),
      'Đã có lỗi xảy ra, vui lòng thử lại',
    );
  });
}
