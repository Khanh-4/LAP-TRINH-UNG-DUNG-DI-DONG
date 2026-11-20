import 'package:intl/intl.dart';

/// Định dạng dùng chung cho toàn app (tiền VND, ngày tháng).
abstract final class Formatters {
  static final NumberFormat _vnd = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );
  static final DateFormat _date = DateFormat('dd/MM/yyyy');

  static String currency(num amount) => _vnd.format(amount);

  static String date(DateTime value) => _date.format(value);
}
