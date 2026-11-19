import 'package:expense_ai/features/auth/data/fake_auth_repository.dart';
import 'package:expense_ai/features/auth/presentation/auth_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthController controller;

  setUp(() => controller = AuthController(FakeAuthRepository()));
  tearDown(() => controller.dispose());

  test('starts signed out', () {
    expect(controller.isSignedIn, isFalse);
  });

  test('sign in with invalid email fails and exposes error message', () async {
    final ok = await controller.signIn(email: 'abc', password: '123456');

    expect(ok, isFalse);
    expect(controller.isSignedIn, isFalse);
    expect(controller.errorMessage, 'Email không hợp lệ');
  });

  test('sign in with short password fails', () async {
    final ok = await controller.signIn(email: 'a@b.com', password: '123');

    expect(ok, isFalse);
    expect(controller.errorMessage, contains('6 ký tự'));
  });

  test('sign in with valid credentials signs in and trims email', () async {
    final ok = await controller.signIn(email: ' a@b.com ', password: '123456');

    expect(ok, isTrue);
    expect(controller.user?.email, 'a@b.com');
    expect(controller.errorMessage, isNull);
    expect(controller.isLoading, isFalse);
  });

  test('sign out clears user', () async {
    await controller.signIn(email: 'a@b.com', password: '123456');

    await controller.signOut();

    expect(controller.isSignedIn, isFalse);
  });
}
