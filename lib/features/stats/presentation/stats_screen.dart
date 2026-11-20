import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_view.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thống kê')),
      body: const PlaceholderView(
        icon: Icons.bar_chart_outlined,
        title: 'Thống kê',
        description: 'C phụ trách: biểu đồ chi tiêu theo tháng và danh mục.',
      ),
    );
  }
}
