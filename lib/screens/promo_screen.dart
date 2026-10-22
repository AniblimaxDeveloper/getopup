import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/banners.dart';
import '../data/vouchers.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Promo & Voucher')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text('Promo Spesial',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...promoBanners.map((b) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: b.colors),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(b.tag,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),
                    Text(b.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(b.subtitle,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12, height: 1.4)),
                  ],
                ),
              )),
          const SizedBox(height: 20),
          const Text('Daftar Voucher',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...vouchers.map((v) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.local_offer,
                        color: Color(0xFF1565C0)),
                  ),
                  title: Text(v.code,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(v.description),
                  trailing: TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: v.code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Kode ${v.code} disalin')),
                      );
                    },
                    child: const Text('Salin'),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
