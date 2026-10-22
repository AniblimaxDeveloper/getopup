import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/app_state.dart';

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
                  Expanded(child: _statCard('Saldo',
                      rupiah.format(state.balance), Icons.wallet, Colors.blue)),
                  const SizedBox(width: 8),
                  Expanded(child: _statCard('Top Up',
                      '$gameTx kali', Icons.sports_esports, Colors.green)),
                  const SizedBox(width: 8),
                  Expanded(child: _statCard('Voucher',
                      '${state.usedVouchers.length}', Icons.local_offer,
                      Colors.orange)),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Ubah Nama'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final controller =
                            TextEditingController(text: state.userName);
                        final v = await showDialog<String>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Ubah Nama'),
                            content: TextField(
                              controller: controller,
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
                                      Navigator.pop(context, controller.text),
                                  child: const Text('Simpan')),
                            ],
                          ),
                        );
                        if (v != null) await state.setUserName(v);
                      },
                    ),
                    const Divider(height: 1),
                    const ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text('Bantuan & FAQ'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 1),
                    const ListTile(
                      leading: Icon(Icons.privacy_tip_outlined),
                      title: Text('Kebijakan Privasi'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 1),
                    const ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('Tentang GeTopUp'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: const Text('Reset Semua Data',
                      style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Reset Semua Data?'),
                        content: const Text(
                            'Saldo, riwayat, dan profil akan dihapus permanen.'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Batal')),
                          TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Hapus',
                                  style: TextStyle(color: Colors.red))),
                        ],
                      ),
                    );
                    if (ok == true) await state.clearAll();
                  },
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Text('GeTopUp v4.0.0',
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

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
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
