import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/data/fake_auth_repository.dart';
import 'features/auth/data/firebase_auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ExpenseApp(authRepository: await _createAuthRepository()));
}

/// Dùng Firebase nếu máy đã có file cấu hình (google-services.json /
/// GoogleService-Info.plist); nếu chưa thì quay về đăng nhập giả lập
/// để app vẫn chạy được.
Future<AuthRepository> _createAuthRepository() async {
  try {
    await Firebase.initializeApp();
    return FirebaseAuthRepository(FirebaseAuth.instance);
  } catch (e) {
    debugPrint('Firebase chưa được cấu hình, dùng đăng nhập giả lập. Lỗi: $e');
    return FakeAuthRepository();
  }
}
