import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_controller.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/home/presentation/home_shell.dart';
import '../../features/scan/presentation/scan_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/stats/presentation/stats_screen.dart';
import '../../features/transactions/presentation/transactions_screen.dart';
import 'app_routes.dart';

GoRouter createRouter(AuthController auth) {
  return GoRouter(
    initialLocation: AppRoutes.transactions,
    refreshListenable: auth,
    redirect: (context, state) {
      final isPublic = AppRoutes.public.contains(state.matchedLocation);
      if (!auth.isSignedIn) return isPublic ? null : AppRoutes.login;
      if (isPublic) return AppRoutes.transactions;
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, _) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => HomeShell(navigationShell: shell),
        branches: [
          _branch(AppRoutes.transactions, const TransactionsScreen()),
          _branch(AppRoutes.scan, const ScanScreen()),
          _branch(AppRoutes.stats, const StatsScreen()),
          _branch(AppRoutes.settings, const SettingsScreen()),
        ],
      ),
    ],
  );
}

StatefulShellBranch _branch(String path, Widget screen) {
  return StatefulShellBranch(
    routes: [GoRoute(path: path, builder: (_, _) => screen)],
  );
}
