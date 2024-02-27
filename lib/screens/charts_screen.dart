import 'package:flutter/material.dart';

import '../widgets/dashboard_drawer.dart';

class ChartsScreen extends StatelessWidget {
  static const routeName = '/charts-screen';
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DashboardDrawer(),
      appBar: AppBar(
        title: const Text('Charts'),
      ),
    );
  }
}
