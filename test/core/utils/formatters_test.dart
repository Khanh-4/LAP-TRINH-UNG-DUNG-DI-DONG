import 'package:expense_ai/core/utils/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('currency formats VND with dot separators and đồng symbol', () {
    final result = Formatters.currency(1250000);

    expect(result, contains('1.250.000'));
    expect(result, contains('₫'));
  });

  test('date formats as dd/MM/yyyy', () {
    expect(Formatters.date(DateTime(2026, 3, 5)), '05/03/2026');
  });
}
