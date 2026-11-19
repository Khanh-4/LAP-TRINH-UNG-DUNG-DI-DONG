import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_view.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quét hóa đơn')),
      body: const PlaceholderView(
        icon: Icons.document_scanner_outlined,
        title: 'Quét hóa đơn',
        description:
            'C phụ trách: chụp hóa đơn, Gemini đọc số tiền, ngày, cửa hàng.',
      ),
    );
  }
}
