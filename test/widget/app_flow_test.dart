import 'package:expense_ai/app.dart';
import 'package:expense_ai/features/auth/data/fake_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('unauthenticated user is redirected to login', (tester) async {
    await tester.pumpWidget(ExpenseApp(authRepository: FakeAuthRepository()));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('login_submit')), findsOneWidget);
  });

  testWidgets('login form shows validation errors for empty input', (
    tester,
  ) async {
    await tester.pumpWidget(ExpenseApp(authRepository: FakeAuthRepository()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('login_submit')));
    await tester.pump();

    expect(find.text('Vui lòng nhập email'), findsOneWidget);
  });

  testWidgets('login → home tabs → sign out returns to login', (tester) async {
    await tester.pumpWidget(ExpenseApp(authRepository: FakeAuthRepository()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('login_email')), 'a@b.com');
    await tester.enterText(find.byKey(const Key('login_password')), '123456');
    await tester.tap(find.byKey(const Key('login_submit')));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('Cài đặt'));
    await tester.pumpAndSettle();
    expect(find.text('a@b.com'), findsOneWidget);

    await tester.tap(find.byKey(const Key('settings_sign_out')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('login_submit')), findsOneWidget);
  });
}
