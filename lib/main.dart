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
        textTheme: _scaled(ThemeData.light().textTheme, fontScale),
      );

  ThemeData _darkTheme(ThemeColorOption tc, double fontScale) => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: tc.accent,
          onPrimary: Colors.black,
          primaryContainer: tc.dark,
          onPrimaryContainer: Colors.white,
          secondary: const Color(0xFFFFC107),
          onSecondary: Colors.black,
          secondaryContainer: const Color(0xFF2A2417),
          onSecondaryContainer: const Color(0xFFFFE082),
          tertiary: tc.accent,
          onTertiary: Colors.black,
          error: const Color(0xFFCF6679),
          onError: Colors.black,
          surface: const Color(0xFF151A21),
          onSurface: const Color(0xFFE8EAED),
          surfaceContainerHighest: const Color(0xFF1F2630),
          onSurfaceVariant: const Color(0xFF9AA0A6),
        ),
        scaffoldBackgroundColor: const Color(0xFF0B0E11),
        canvasColor: const Color(0xFF0B0E11),
        cardColor: const Color(0xFF151A21),
        dividerColor: const Color(0xFF232A33),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F1318),
          elevation: 0,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF0F1318),
          indicatorColor: tc.accent.withOpacity(0.2),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFF151A21),
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: Color(0xFF1F2630),
          selectedColor: Color(0xFF1565C0),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF151A21),
          hintStyle: const TextStyle(color: Color(0xFF6E7681)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF232A33)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF232A33)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: tc.accent, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: tc.accent,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        textTheme: _scaled(ThemeData.dark().textTheme, fontScale),
      );

  TextTheme _scaled(TextTheme base, double scale) =>
      base.apply(fontSizeFactor: scale);
}
