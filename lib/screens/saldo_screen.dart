import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/app_state.dart';
import 'receipt_screen.dart';

class SaldoScreen extends StatefulWidget {
  const SaldoScreen({super.key});
  @override
  State<SaldoScreen> createState() => _SaldoScreenState();
}

class _SaldoScreenState extends State<SaldoScreen> {
  final _amounts = [
    10000, 20000, 25000, 50000, 100000, 150000, 250000, 500000, 1000000
  ];
  final Map<String, IconData> _methods = {
    'DANA': Icons.account_balance_wallet,
    'OVO': Icons.account_balance_wallet,
    'GoPay': Icons.account_balance_wallet,
    'ShopeePay': Icons.account_balance_wallet,
    'QRIS': Icons.qr_code,
    'BCA VA': Icons.account_balance,
    'BRI VA': Icons.account_balance,
    'Mandiri VA': Icons.account_balance,
    'Alfamart': Icons.store,
    'Indomaret': Icons.store,
  };
  int _selected = 10000;
  String _method = 'DANA';
  bool _loading = false;

  Future<void> _pay() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    final tx = await AppState.instance.topupSaldo(_selected, _method);
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => ReceiptScreen(tx: tx)));
  }

  Future<void> _openMidtransGuide() async {
    final url = Uri.parse('https://docs.midtrans.com/docs/snap-snap-integration-guide');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Scaffold(
      appBar: AppBar(title: const Text('Isi Saldo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nominal Dipilih',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    rupiah.format(_selected),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Pilih Nominal',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.2,
              physics: const NeverScrollableScrollPhysics(),
              children: _amounts.map((a) {
                final active = a == _selected;
                return InkWell(
                  onTap: () => setState(() => _selected = a),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active
                          ? Colors.blue.shade50
                          : Colors.grey.shade100,
                      border: Border.all(
                          color: active ? Colors.blueAccent : Colors.transparent,
                          width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      rupiah.format(a),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: active ? Colors.blue.shade800 : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Metode Pembayaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._methods.entries.map((e) => Card(
                  margin: const EdgeInsets.only(bottom: 6),
                  color: _method == e.key ? Colors.blue.shade50 : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                        color: _method == e.key
                            ? Colors.blueAccent
                            : Colors.transparent,
                        width: 2),
                  ),
                  child: ListTile(
                    onTap: () => setState(() => _method = e.key),
                    leading: Icon(e.value, color: Colors.blueAccent),
                    title: Text(e.key),
                    trailing: Radio<String>(
                      value: e.key,
                      groupValue: _method,
                      onChanged: (v) => setState(() => _method = v!),
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Bayar', style: TextStyle(fontSize: 16)),
                  Text(
                    rupiah.format(_selected),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _pay,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
              ),
              child: _loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2))
                  : const Text('Bayar Sekarang',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _openMidtransGuide,
              icon: const Icon(Icons.credit_card),
              label: const Text('Aktifkan Pembayaran Asli (Midtrans)'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
