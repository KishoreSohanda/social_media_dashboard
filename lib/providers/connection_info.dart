import 'dart:io';

import 'package:flutter/material.dart';

enum InternetConnectivity { connected, disconnected }

class ConnectionInfo with ChangeNotifier {
  InternetConnectivity? internet;

  Future<bool> internetConnectivity() async {
    bool connectivity = true;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
        internet = InternetConnectivity.connected;
        connectivity = true;
      }
    } on SocketException catch (_) {
      // print('not connected');
      internet = InternetConnectivity.disconnected;
      connectivity = false;
    }
    notifyListeners();
    return connectivity;
  }

  SnackBar? errorSnackbar(BuildContext ctx) {
    if (internet == InternetConnectivity.connected) {
      return null;
    }
    if (internet == InternetConnectivity.disconnected) {
      return SnackBar(
        content: Text(
          'Check your internet connection',
          style: TextStyle(color: Theme.of(ctx).colorScheme.error),
        ),
      );
    }
    return null;
  }
}
