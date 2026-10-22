import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  final _faqs = const [
    ('Apa itu GeTopUp?',
        'GeTopUp adalah aplikasi top up game dengan 60+ game dan voucher. Dompet digital tersimpan di perangkat Anda.'),
    ('Bagaimana cara isi saldo?',
        'Buka Beranda → Isi Saldo → pilih nominal & metode → bayar. Di versi ini pembayaran masih simulasi lokal.'),
    ('Apakah item game langsung masuk ke akun?',
        'Belum. Versi ini adalah dompet digital lokal. Untuk pengiriman diamond/UC nyata dibutuhkan integrasi ke API provider resmi seperti Digiflazz.'),
    ('Bagaimana cara pakai voucher?',
        'Salin kode voucher di tab Promo → tempel di kolom voucher halaman game → tekan Pakai. Voucher hanya bisa dipakai sekali.'),
    ('Kenapa saldo tidak berkurang saat beli?',
        'Pastikan saldo mencukupi. Jika kurang, akan muncul dialog untuk isi saldo terlebih dahulu.'),
    ('Apa itu Daily Check-in?',
        'Bonus Rp 500 gratis setiap hari. Buka Beranda → tap tombol check-in di header.'),
    ('Bagaimana cara ubah PIN?',
        'Buka Profil → Keamanan → Ubah PIN.'),
    ('Apakah data saya aman?',
        'Semua data (saldo, riwayat, PIN) tersimpan lokal di perangkat. Tidak ada data yang dikirim ke server.'),
    ('Bagaimana reset data?',
        'Profil → Reset Semua Data. Saldo, riwayat, favorit, dan PIN akan dihapus permanen.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bantuan & FAQ')),
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
        ],
      ),
    );
  }
}
