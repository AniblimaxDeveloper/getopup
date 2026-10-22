import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Syarat & Ketentuan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _h('1. Penerimaan Ketentuan'),
            _p('Dengan menggunakan GeTopUp, Anda setuju dengan seluruh syarat dan ketentuan yang berlaku.'),
            _h('2. Layanan'),
            _p('GeTopUp menyediakan layanan dompet digital untuk pembelian produk game dan voucher digital. Semua transaksi tercatat dan dapat dilihat di riwayat.'),
            _h('3. Saldo'),
            _p('Saldo yang diisi melalui simulasi lokal hanya tersimpan di perangkat Anda. GeTopUp tidak bertanggung jawab atas kehilangan data akibat uninstall, reset perangkat, atau kerusakan perangkat.'),
            _h('4. Voucher'),
            _p('Setiap voucher hanya dapat digunakan satu kali. Voucher dapat dihentikan sewaktu-waktu tanpa pemberitahuan.'),
            _h('5. Pengembalian Dana'),
            _p('Transaksi yang sudah berhasil tidak dapat dibatalkan atau dikembalikan, kecuali terdapat kesalahan sistem yang dapat dibuktikan.'),
            _h('6. Larangan'),
            _p('Dilarang menggunakan aplikasi untuk aktivitas ilegal, penipuan, atau pelanggaran hukum yang berlaku di Indonesia.'),
            _h('7. Perubahan'),
            _p('GeTopUp berhak mengubah syarat dan ketentuan kapan saja. Perubahan berlaku setelah dipublikasikan di aplikasi.'),
            _h('8. Kontak'),
            _p('Pertanyaan: legal@getopup.com'),
            const SizedBox(height: 24),
            Center(
              child: Text('Terakhir diperbarui: Januari 2024',
                  style:
                      TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _h(String s) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 6),
        child: Text(s,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      );

  Widget _p(String s) => Text(s,
      style: TextStyle(
          fontSize: 13, color: Colors.grey.shade700, height: 1.6));
}
