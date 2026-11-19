import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import 'auth_controller.dart';
import 'auth_validators.dart';
import 'widgets/auth_error_text.dart';
import 'widgets/submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await context.read<AuthController>().signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  Future<void> _forgotPassword() async {
    final messenger = ScaffoldMessenger.of(context);
    final auth = context.read<AuthController>();
    final email = _emailController.text.trim();
    if (AuthValidators.email(email) != null) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Nhập email ở trên trước để đặt lại mật khẩu'),
        ),
      );
      return;
    }
    final ok = await auth.sendPasswordReset(email);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Đã gửi email đặt lại mật khẩu tới $email'
              : auth.errorMessage ?? 'Không gửi được email',
        ),
      ),
    );
  }

  void _goToRegister() {
    context.read<AuthController>().clearError();
    context.push(AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 72,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppConstants.appName,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    key: const Key('login_email'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: AuthValidators.email,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('login_password'),
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Mật khẩu'),
                    validator: AuthValidators.password,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      key: const Key('login_forgot_password'),
                      onPressed: auth.isLoading ? null : _forgotPassword,
                      child: const Text('Quên mật khẩu?'),
                    ),
                  ),
                  AuthErrorText(message: auth.errorMessage),
                  const SizedBox(height: 12),
                  SubmitButton(
                    key: const Key('login_submit'),
                    label: 'Đăng nhập',
                    isLoading: auth.isLoading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    key: const Key('login_go_register'),
                    onPressed: auth.isLoading ? null : _goToRegister,
                    child: const Text('Chưa có tài khoản? Đăng ký'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
