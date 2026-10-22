import 'package:flutter/material.dart';
import 'services/app_state.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppState.instance.load();
  runApp(const GeTopUpApp());
}

class GeTopUpApp extends StatelessWidget {
  const GeTopUpApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeTopUp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black87,
          centerTitle: false,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
