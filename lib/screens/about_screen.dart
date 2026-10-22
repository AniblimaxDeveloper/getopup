import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang GeTopUp')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.sports_esports,
                  size: 64, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text('GeTopUp',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          const Center(
            child: Text('Versi 5.0.0',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.web),
                  title: const Text('Website'),
                  subtitle: const Text('getopup.com'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text('Email'),
                  subtitle: const Text('support@getopup.com'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('Dibuat dengan'),
                  subtitle: const Text('Flutter + Material 3'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fitur Utama',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  ...[
                    '60+ game & voucher digital',
                    'Sistem voucher & diskon',
                    'Dompet digital dengan PIN',
                    'Daily check-in bonus Rp 500',
                    'Riwayat & bukti transaksi',
                    'Achievement & pencapaian',
                    'Dark mode',
                  ].map((f) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.green, size: 16),
                            const SizedBox(width: 8),
                            Text(f, style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text('© 2024 getopup.com\nAll rights reserved',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.grey.shade600, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
