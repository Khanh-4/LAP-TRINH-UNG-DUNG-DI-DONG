abstract final class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';

  /// Các route được vào khi chưa đăng nhập.
  static const Set<String> public = {login, register};
  static const String transactions = '/transactions';
  static const String scan = '/scan';
  static const String stats = '/stats';
  static const String settings = '/settings';
}
