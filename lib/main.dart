import 'package:flutter/material.dart';
import 'services/app_state.dart';
import 'screens/root_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const RootScreen(),
    );
  }
}
