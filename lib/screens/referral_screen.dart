import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/app_state.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final code = AppState.instance.referralCode;
    return Scaffold(
      appBar: AppBar(title: const Text('Ajak Teman')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Icon(Icons.card_giftcard, color: Colors.white, size: 64),
                const SizedBox(height: 12),
                const Text('Dapatkan Rp 10.000',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('untuk kamu & temanmu',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(code,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4)),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: code));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Kode referral disalin')));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms).scale(curve: Curves.elasticOut),
          const SizedBox(height: 20),
          const Text('Cara Kerja',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...[
            ('1', 'Bagikan kode referral ke teman'),
            ('2', 'Teman mendaftar & memasukkan kodemu'),
            ('3', 'Kalian berdua dapat Rp 10.000'),
          ].map((s) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF6A1B9A),
                    child: Text(s.$1,
                        style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(s.$2),
                ),
              )),
        ],
      ),
    );
  }
}
