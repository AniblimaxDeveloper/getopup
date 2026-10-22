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
        return Scaffold(
          appBar: AppBar(title: const Text('Profil')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person, size: 48),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(state.userName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.account_balance_wallet),
                  title: const Text('Saldo'),
                  trailing: Text(
                    rupiah.format(state.balance),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: const Text('Total Transaksi'),
                  trailing: Text(
                    '${state.history.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Ubah Nama'),
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
                          decoration:
                              const InputDecoration(hintText: 'Nama baru'),
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
              ),
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
                            'Saldo, riwayat, dan profil akan dihapus.'),
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
                child: Text(
                  'GeTopUp v2.0\nSimulasi pembayaran lokal',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
