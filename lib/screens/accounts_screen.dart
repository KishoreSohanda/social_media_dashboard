import 'package:flutter/material.dart';

import '../widgets/dashboard_drawer.dart';

class AccountsScreen extends StatelessWidget {
  static const routeName = '/accounts-screen';
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DashboardDrawer(),
      appBar: AppBar(
        title: const Text('Your Accounts'),
      ),
    );
  }
}
