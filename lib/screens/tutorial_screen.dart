import 'package:flutter/material.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  final _steps = const [
    ('1', 'Isi Saldo Dulu', Icons.account_balance_wallet,
        'Buka Beranda → Isi Saldo → pilih nominal & metode → tap Bayar. Saldo otomatis masuk.'),
    ('2', 'Pilih Game Favorit', Icons.sports_esports,
        'Tap salah satu game di Beranda. Kamu bisa gunakan filter kategori atau search.'),
    ('3', 'Masukkan User ID', Icons.person,
        'Isi User ID (dan Zone ID jika ada). Cek dulu di profil game-mu supaya tidak salah.'),
    ('4', 'Pilih Nominal', Icons.card_giftcard,
        'Pilih paket item — ada label HOT/PROMO untuk yang paling worth it.'),
    ('5', 'Pakai Voucher', Icons.local_offer,
        'Kalau ada kode voucher, tempel di kolom Voucher → Pakai. Bisa hemat s.d. Rp 100.000.'),
    ('6', 'Bayar dengan Saldo', Icons.check_circle,
        'Tap Bayar → saldo otomatis terpotong → bukti transaksi muncul dengan kode unik.'),
    ('7', 'Cek Riwayat', Icons.receipt_long,
        'Semua transaksi tersimpan di tab Riwayat. Bisa difilter & diekspor.'),
    ('8', 'Check-in Harian', Icons.calendar_today,
        'Setiap hari dapat bonus Rp 500+. Streak berturut-turut = bonus makin besar s.d. Rp 2.000.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tutorial')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.school, color: Colors.white, size: 40),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Panduan Pemula',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text('Ikuti 8 langkah ini',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ..._steps.map((s) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF1565C0),
                        child: Text(s.$1,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(s.$3,
                                    size: 16,
                                    color: const Color(0xFF1565C0)),
                                const SizedBox(width: 6),
                                Text(s.$2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(s.$4,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
