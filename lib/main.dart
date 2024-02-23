import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:social_media_dashboard/firebase_options.dart';

import 'package:flutter/material.dart';
import './providers/connection_info.dart';
import './screens/splash_loading_screen.dart';

import './screens/auth_screen.dart';
import './screens/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => ConnectionInfo(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DashBoard for all your social media accounts',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color.fromRGBO(8, 29, 46, 0.986),
          secondary: const Color.fromRGBO(64, 171, 251, 1),
          tertiary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(8, 29, 46, 0.986),
          foregroundColor: Color.fromRGBO(64, 171, 251, 1),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.black),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            iconColor: MaterialStatePropertyAll(Colors.black),
          ),
        ),
      ),
      routes: {
        '/': (context) => StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashLoadingScreen();
                }
                if (snapshot.hasData) {
                  return const DashboardScreen();
                }
                return const AuthScreen();
              },
            ),
        AuthScreen.routeName: (ctx) => const AuthScreen(),
        DashboardScreen.routeName: (ctx) => const DashboardScreen(),
      },
    );
  }
}
