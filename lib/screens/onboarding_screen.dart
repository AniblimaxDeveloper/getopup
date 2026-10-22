import 'package:flutter/material.dart';
import '../services/app_state.dart';
import 'root_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  final _pages = const [
    _PageData(icon: Icons.sports_esports, color: Color(0xFF1565C0),
        title: '60+ Game Tersedia',
        desc: 'Top up semua game favoritmu — Mobile Legends, Free Fire, PUBG, Genshin, dan banyak lagi.'),
    _PageData(icon: Icons.local_offer, color: Color(0xFF2E7D32),
        title: 'Voucher & Promo',
        desc: 'Gunakan kode voucher untuk diskon hingga Rp 100.000 setiap transaksi.'),
    _PageData(icon: Icons.account_balance_wallet, color: Color(0xFFEF6C00),
        title: 'Isi Saldo Instan',
        desc: 'Top up saldo dengan DANA, OVO, GoPay, QRIS, atau transfer bank — langsung masuk.'),
    _PageData(icon: Icons.verified, color: Color(0xFF6A1B9A),
        title: 'Aman & Terpercaya',
        desc: 'Transaksi tersimpan permanen, bukti digital, dan keamanan terjamin.'),
  ];

  Future<void> _finish() async {
    await AppState.instance.completeOnboarding();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const RootScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _finish,
                child: const Text('Lewati'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _index = i),
                itemCount: _pages.length,
                itemBuilder: (context, i) {
                  final p = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: p.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(p.icon, size: 100, color: p.color),
                        ),
                        const SizedBox(height: 40),
                        Text(p.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Text(p.desc,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade700,
                                height: 1.5)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _index == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _index == i ? const Color(0xFF1565C0) : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_index < _pages.length - 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _finish();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF1565C0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    _index == _pages.length - 1 ? 'Mulai Sekarang' : 'Lanjut',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageData {
  final IconData icon;
  final Color color;
  final String title, desc;
  const _PageData({
    required this.icon,
    required this.color,
    required this.title,
    required this.desc,
  });
}
