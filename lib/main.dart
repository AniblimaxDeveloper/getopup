import 'package:flutter/material.dart';
import 'services/app_state.dart';
import 'data/theme_colors.dart';
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
        final tc = themeColorOptions[s.themeColorIndex];
        return MaterialApp(
          title: 'GeTopUp',
          debugShowCheckedModeBanner: false,
          themeMode: s.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: _lightTheme(tc, s.fontScale),
          darkTheme: _darkTheme(tc, s.fontScale),
          home: const SplashScreen(),
        );
      },
    );
  }

  ThemeData _lightTheme(ThemeColorOption tc, double fontScale) => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: tc.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black87,
        ),
        textTheme: _scaled(ThemeData.light().textTheme, fontScale),
      );

  ThemeData _darkTheme(ThemeColorOption tc, double fontScale) => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: tc.primary,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        cardColor: const Color(0xFF1E1E1E),
        textTheme: _scaled(ThemeData.dark().textTheme, fontScale),
      );

  TextTheme _scaled(TextTheme base, double scale) =>
      base.apply(fontSizeFactor: scale);
}
