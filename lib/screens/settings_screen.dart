import 'package:flutter/material.dart';
import '../services/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final s = AppState.instance;
        return Scaffold(
          appBar: AppBar(title: const Text('Pengaturan')),
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              _section('Tampilan'),
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: Icon(s.darkMode
                          ? Icons.dark_mode
                          : Icons.light_mode),
                      title: const Text('Mode Gelap'),
                      subtitle: Text(s.darkMode ? 'Aktif' : 'Nonaktif'),
                      value: s.darkMode,
                      onChanged: (v) => s.setDarkMode(v),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.text_fields),
                      title: const Text('Ukuran Font'),
                      subtitle: Text('${(s.fontScale * 100).round()}%'),
                      trailing: SizedBox(
                        width: 150,
                        child: Slider(
                          value: s.fontScale,
                          min: 0.8,
                          max: 1.4,
                          divisions: 6,
                          onChanged: (v) => s.setFontScale(v),
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Bahasa'),
                      subtitle: Text(s.language == 'id' ? 'Indonesia' : 'English'),
                      trailing: DropdownButton<String>(
                        value: s.language,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(value: 'id', child: Text('Indonesia')),
                          DropdownMenuItem(value: 'en', child: Text('English')),
                        ],
                        onChanged: (v) => s.setLanguage(v ?? 'id'),
                      ),
                    ),
                  ],
                ),
              ),
              _section('Notifikasi'),
              Card(
                child: SwitchListTile(
                  secondary: const Icon(Icons.notifications_active),
                  title: const Text('Notifikasi Dalam Aplikasi'),
                  subtitle: const Text('Tampilkan notifikasi transaksi'),
                  value: s.notifEnabled,
                  onChanged: (v) => s.setNotifEnabled(v),
                ),
              ),
              _section('Keamanan'),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.lock_outline),
                  title: const Text('Ubah PIN'),
                  subtitle: Text(s.hasPin ? 'PIN aktif' : 'Belum ada PIN'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final c = TextEditingController();
                    final v = await showDialog<String>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Ubah PIN'),
                        content: TextField(
                          controller: c,
                          autofocus: true,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          decoration: const InputDecoration(
                              hintText: 'PIN baru (4-6 digit)'),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Batal')),
                          TextButton(
                              onPressed: () => Navigator.pop(ctx, c.text),
                              child: const Text('Simpan')),
                        ],
                      ),
                    );
                    if (v != null && v.length >= 4) {
                      await s.setPin(v);
                    }
                  },
                ),
              ),
              _section('Tentang'),
              Card(
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('Versi Aplikasi'),
                      trailing: Text('5.0.1'),
                    ),
                    const Divider(height: 1),
                    const ListTile(
                      leading: Icon(Icons.code),
                      title: Text('Dibuat dengan'),
                      trailing: Text('Flutter 3.27'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text('© 2024 getopup.com',
                    style: TextStyle(
                        color: Colors.grey.shade500, fontSize: 11)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _section(String label) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 16, 4, 6),
        child: Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
      );
}
