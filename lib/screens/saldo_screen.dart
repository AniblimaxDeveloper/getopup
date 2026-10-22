import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/app_state.dart';
import 'receipt_screen.dart';

class SaldoScreen extends StatefulWidget {
  const SaldoScreen({super.key});
  @override
  State<SaldoScreen> createState() => _SaldoScreenState();
}

class _SaldoScreenState extends State<SaldoScreen> {
  final _amounts = [10000, 25000, 50000, 100000, 250000, 500000];
  final _methods = ['DANA', 'OVO', 'GoPay', 'QRIS', 'ShopeePay'];
  int _selected = 10000;
  String _method = 'DANA';
  bool _loading = false;

  Future<void> _pay() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    final tx = await AppState.instance.topupSaldo(_selected, _method);
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ReceiptScreen(tx: tx)),
    );
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
            const Text('Pilih Nominal',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2,
              physics: const NeverScrollableScrollPhysics(),
              children: _amounts.map((a) {
                final active = a == _selected;
                return InkWell(
                  onTap: () => setState(() => _selected = a),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active ? Colors.blue.shade50 : Colors.grey.shade100,
                      border: Border.all(
                        color: active ? Colors.blueAccent : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      rupiah.format(a),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: active ? Colors.blue.shade800 : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Metode Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._methods.map((m) => RadioListTile<String>(
                  value: m,
                  groupValue: _method,
                  onChanged: (v) => setState(() => _method = v!),
                  title: Text(m),
                  contentPadding: EdgeInsets.zero,
                )),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Bayar',
                      style: TextStyle(fontSize: 16)),
                  Text(
                    rupiah.format(_selected),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
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
                          color: Colors.white, strokeWidth: 2),
                    )
                  : const Text('Bayar Sekarang',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
