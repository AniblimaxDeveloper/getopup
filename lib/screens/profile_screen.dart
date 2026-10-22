import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/app_state.dart';
import 'achievements_screen.dart';
import 'favorites_screen.dart';
import 'faq_screen.dart';
import 'notifications_screen.dart';
import 'terms_screen.dart';
import 'about_screen.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;
        final gameTx = state.history.where((t) => t.type == 'game').length;
        final unlocked =
            (gameTx >= 1 ? 1 : 0) +
                (gameTx >= 5 ? 1 : 0) +
                (gameTx >= 10 ? 1 : 0) +
                (gameTx >= 20 ? 1 : 0) +
                (gameTx >= 50 ? 1 : 0);
        return Scaffold(
          appBar: AppBar(title: const Text('Profil')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xFFE3F2FD),
                  child: const Icon(Icons.person,
                      size: 50, color: Color(0xFF1565C0)),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(state.userName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text('getopup.com member',
                    style: TextStyle(
                        color: Colors.grey.shade600, fontSize: 12)),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: _stat('Saldo', rupiah.format(state.balance),
                          Icons.wallet, Colors.blue)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _stat('Top Up', '$gameTx kali',
                          Icons.sports_esports, Colors.green)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _stat('Badge', '$unlocked/5',
                          Icons.emoji_events, Colors.amber)),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: Icon(
                        state.darkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                      ),
                      title: const Text('Mode Gelap'),
                      subtitle: Text(state.darkMode ? 'Aktif' : 'Nonaktif'),
                      value: state.darkMode,
                      onChanged: (v) => state.setDarkMode(v),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.star),
                      title: const Text('Game Favorit'),
                      subtitle: Text('${state.favorites.length} game'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FavoritesScreen())),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.emoji_events),
                      title: const Text('Pencapaian'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AchievementsScreen())),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: const Text('Notifikasi'),
                      subtitle: Text('${state.unreadCount} belum dibaca'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const NotificationsScreen()));
                        state.markNotificationsRead();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Ubah Nama'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final c =
                            TextEditingController(text: state.userName);
                        final v = await showDialog<String>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Ubah Nama'),
                            content: TextField(
                              controller: c,
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Nama baru'),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Batal')),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, c.text),
                                  child: const Text('Simpan')),
                            ],
                          ),
                        );
                        if (v != null) await state.setUserName(v);
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.lock_outline),
                      title: const Text('Ubah PIN'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final c = TextEditingController();
                        final v = await showDialog<String>(
                          context: context,
                          builder: (_) => AlertDialog(
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
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Batal')),
                              TextButton(
                                  onPressed: () {
                                    if (c.text.length >= 4) {
                                      Navigator.pop(context, c.text);
                                    }
                                  },
                                  child: const Text('Simpan')),
                            ],
                          ),
                        );
                        if (v != null && v.length >= 4) {
                          await state.setPin(v);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('PIN berhasil diubah')));
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.help_outline),
                      title: const Text('Bantuan & FAQ'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FaqScreen())),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip_outlined),
                      title: const Text('Syarat & Ketentuan'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TermsScreen())),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('Tentang GeTopUp'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AboutScreen())),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.orange),
                      title: const Text('Keluar',
                          style: TextStyle(color: Colors.orange)),
                      onTap: () async {
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Keluar?'),
                            content:
                                const Text('Anda perlu memasukkan PIN lagi.'),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Batal')),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, true),
                                  child: const Text('Keluar')),
                            ],
                          ),
                        );
                        if (ok == true) {
                          state.logout();
                          if (!context.mounted) return;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AuthScreen()),
                            (route) => false,
                          );
                        }
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading:
                          const Icon(Icons.delete_forever, color: Colors.red),
                      title: const Text('Reset Semua Data',
                          style: TextStyle(color: Colors.red)),
                      onTap: () async {
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Reset Semua Data?'),
                            content: const Text(
                                'Saldo, riwayat, favorit, dan profil akan dihapus permanen.'),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Batal')),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, true),
                                  child: const Text('Hapus',
                                      style: TextStyle(color: Colors.red))),
                            ],
                          ),
                        );
                        if (ok == true) await state.clearAll();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Text('GeTopUp v5.0.0',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12)),
                    const SizedBox(height: 2),
                    Text('© 2024 getopup.com',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _stat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(value,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          Text(label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 10)),
        ],
      ),
    );
  }
}
