import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  final _faqs = const [
    ('Apa itu GeTopUp?',
        'GeTopUp adalah aplikasi top up game dengan 85+ game dan voucher. Dompet digital tersimpan di perangkat Anda.'),
    ('Bagaimana cara isi saldo?',
        'Buka Beranda → Isi Saldo → pilih nominal & metode → bayar. Pembayaran di versi ini masih simulasi lokal.'),
    ('Apakah item game langsung masuk ke akun?',
        'Belum. Versi ini adalah dompet digital lokal. Untuk pengiriman diamond/UC nyata dibutuhkan API provider (Digiflazz dkk).'),
    ('Bagaimana cara login dengan Google?',
        'Google Sign-In asli memerlukan Firebase project. Ketuk tombol Google → Setup Guide untuk panduan.'),
    ('Bagaimana cara pakai voucher?',
        'Salin kode di tab Promo → tempel di halaman game → tekan Pakai. Sekali pakai per akun.'),
    ('Apa itu Daily Check-in?',
        'Bonus Rp 500 + 10 XP setiap hari. Tap check-in di Beranda.'),
    ('Bagaimana cara ubah PIN?',
        'Profil → Pengaturan → Keamanan → Ubah PIN.'),
    ('Apakah data saya aman?',
        'Semua data tersimpan lokal di perangkat. Tidak ada pengiriman ke server.'),
    ('Bagaimana reset data?',
        'Profil → Reset Semua Data.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bantuan & Info')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.support_agent,
                    color: Color(0xFF1565C0), size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Butuh bantuan?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      Text('Email: support@getopup.com',
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('FAQ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ..._faqs.map((f) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ExpansionTile(
                  title: Text(f.$1,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(f.$2,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              height: 1.5)),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          const Text('Tentang',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
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
                  leading: Icon(Icons.web),
                  title: Text('Website'),
                  subtitle: Text('getopup.com'),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.code),
                  title: Text('Dibuat dengan'),
                  subtitle: Text('Flutter 3.27 · Material 3'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text('© 2024 getopup.com\nAll rights reserved',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey.shade600, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
