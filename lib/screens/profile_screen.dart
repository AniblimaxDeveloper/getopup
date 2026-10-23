import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/app_state.dart';
import 'achievements_screen.dart';
import 'favorites_screen.dart';
import 'help_center_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final s = AppState.instance;
        final gameTx = s.gameTxCount;
        final unlocked =
            (gameTx >= 1 ? 1 : 0) +
                (gameTx >= 5 ? 1 : 0) +
                (gameTx >= 10 ? 1 : 0) +
                (gameTx >= 20 ? 1 : 0) +
                (gameTx >= 50 ? 1 : 0);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profil'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen())),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _pickAvatar(context),
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white, width: 3),
                            ),
                            alignment: Alignment.center,
                            child: Text(s.avatar,
                                style: const TextStyle(fontSize: 40)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s.userName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(
                                      s.loginMethod == 'google'
                                          ? Icons.g_mobiledata
                                          : Icons.person,
                                      color: Colors.white70,
                                      size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    s.loginMethod == 'google'
                                        ? (s.userEmail.isEmpty
                                            ? 'Google'
                                            : s.userEmail)
                                        : 'Tamu',
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 11),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('${s.rank} · Lv.${s.level}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () => _editProfile(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(s.bio,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12)),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('XP: ${s.xpInLevel}/100',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11)),
                            Text(s.rank,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: s.xpInLevel / 100,
                            minHeight: 6,
                            backgroundColor: Colors.white24,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.card_giftcard,
                        color: Colors.amber, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Kode Referral',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.black87)),
                          Text(s.referralCode,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 20),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Kode ${s.referralCode} disalin')),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: _stat(context, 'Saldo',
                          rupiah.format(s.balance), Icons.wallet, Colors.blue)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _stat(context, 'Top Up', '$gameTx',
                          Icons.sports_esports, Colors.green)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _stat(context, 'Badge', '$unlocked/5',
                          Icons.emoji_events, Colors.amber)),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.star),
                      title: const Text('Game Favorit'),
                      subtitle: Text('${s.favorites.length} game'),
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
                      subtitle: Text('${s.unreadCount} belum dibaca'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const NotificationsScreen()));
                        s.markNotificationsRead();
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.help_outline),
                      title: const Text('Bantuan & Info'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HelpCenterScreen())),
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
                          builder: (ctx) => AlertDialog(
                            title: const Text('Keluar?'),
                            content:
                                const Text('Anda perlu login kembali.'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Batal')),
                              TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text('Keluar')),
                            ],
                          ),
                        );
                        if (ok == true) {
                          s.logout();
                          if (!context.mounted) return;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        }
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.delete_forever,
                          color: Colors.red),
                      title: const Text('Reset Semua Data',
                          style: TextStyle(color: Colors.red)),
                      onTap: () async {
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Reset Semua Data?'),
                            content: const Text(
                                'Saldo, riwayat, favorit, dan profil akan dihapus permanen.'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Batal')),
                              TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text('Hapus',
                                      style: TextStyle(color: Colors.red))),
                            ],
                          ),
                        );
                        if (ok == true) await s.clearAll();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Text('GeTopUp v5.0.1',
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

  static Future<void> _pickAvatar(BuildContext context) async {
    const emojis = [
      '😀', '😎', '🦊', '🐯', '🦁', '🐼', '🐨', '🐸', '🦄', '🐲',
      '👾', '🤖', '👻', '🎮', '⚔️', '🛡️', '🔥', '⚡', '💎', '👑',
    ];
    final picked = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          children: emojis
              .map((e) => InkWell(
                    onTap: () => Navigator.pop(ctx, e),
                    child: Center(
                        child:
                            Text(e, style: const TextStyle(fontSize: 32))),
                  ))
              .toList(),
        ),
      ),
    );
    if (picked != null) await AppState.instance.setAvatar(picked);
  }

  static Future<void> _editProfile(BuildContext context) async {
    final nameC =
        TextEditingController(text: AppState.instance.userName);
    final bioC = TextEditingController(text: AppState.instance.bio);
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameC,
              decoration: const InputDecoration(
                  labelText: 'Nama', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bioC,
              maxLines: 2,
              decoration: const InputDecoration(
                  labelText: 'Bio', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Simpan')),
        ],
      ),
    );
    if (result == true) {
      await AppState.instance.setUserName(nameC.text);
      await AppState.instance.setBio(bioC.text);
    }
  }

  Widget _stat(BuildContext context, String label, String value,
      IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
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
              style: TextStyle(
                  color: Colors.grey.shade600, fontSize: 10)),
        ],
      ),
    );
  }
}
