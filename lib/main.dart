import 'package:flutter/material.dart';

import 'app.dart';
import 'features/auth/data/fake_auth_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO(A): thay FakeAuthRepository bằng FirebaseAuthRepository sau khi cấu hình Firebase.
  runApp(ExpenseApp(authRepository: FakeAuthRepository()));
}
