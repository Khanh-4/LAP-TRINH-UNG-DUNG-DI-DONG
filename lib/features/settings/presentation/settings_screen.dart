import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/presentation/auth_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(user?.displayName ?? 'Tài khoản'),
            subtitle: Text(user?.email ?? ''),
          ),
          const Divider(),
          ListTile(
            key: const Key('settings_sign_out'),
            leading: const Icon(Icons.logout),
            title: const Text('Đăng xuất'),
            onTap: () => context.read<AuthController>().signOut(),
          ),
        ],
      ),
    );
  }
}
