import 'package:flutter/material.dart';
import '../data/theme_colors.dart';
import '../services/app_state.dart';

class ThemePickerScreen extends StatelessWidget {
  const ThemePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final current = AppState.instance.themeColorIndex;
        return Scaffold(
          appBar: AppBar(title: const Text('Warna Tema')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Pilih warna utama aplikasi',
                  style: TextStyle(fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
                physics: const NeverScrollableScrollPhysics(),
                children:
                    List.generate(themeColorOptions.length, (i) {
                  final t = themeColorOptions[i];
                  final selected = i == current;
                  return InkWell(
                    onTap: () =>
                        AppState.instance.setThemeColorIndex(i),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [t.dark, t.accent],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selected ? Colors.white : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: t.primary.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(t.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          if (selected)
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Icon(Icons.check_circle,
                                  color: Colors.white, size: 22),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
