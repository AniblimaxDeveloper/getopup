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
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final s = AppState.instance;
        return MaterialApp(
          title: 'GeTopUp',
          debugShowCheckedModeBanner: false,
          themeMode: s.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: _lightTheme(s.fontScale),
          darkTheme: _darkTheme(s.fontScale),
          home: const SplashScreen(),
        );
      },
    );
  }

  ThemeData _lightTheme(double fontScale) => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black87,
        ),
        textTheme: _scaledText(ThemeData.light().textTheme, fontScale),
      );

  ThemeData _darkTheme(double fontScale) => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        cardColor: const Color(0xFF1E1E1E),
        textTheme: _scaledText(ThemeData.dark().textTheme, fontScale),
      );

  TextTheme _scaledText(TextTheme base, double scale) => base.apply(
        fontSizeFactor: scale,
      );
}
