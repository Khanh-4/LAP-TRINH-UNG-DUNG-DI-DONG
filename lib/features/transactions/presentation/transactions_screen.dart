import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_view.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giao dịch')),
      body: const PlaceholderView(
        icon: Icons.receipt_long_outlined,
        title: 'Giao dịch',
        description:
            'B phụ trách: thêm/sửa/xóa thu chi, danh mục, ví, ngân sách.',
      ),
    );
  }
}
