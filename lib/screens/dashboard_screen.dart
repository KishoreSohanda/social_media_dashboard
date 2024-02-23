import 'package:flutter/material.dart';

import '../widgets/dashboard_drawer.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard-screen';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
        title: const Text('Dashboard'),
      ),
      drawer: const DashboardDrawer(),
    );
  }
}
