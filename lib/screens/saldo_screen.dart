import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/payment_method.dart';
import '../services/app_state.dart';
import 'payment_method_screen.dart';
import 'receipt_screen.dart';

class SaldoScreen extends StatefulWidget {
  const SaldoScreen({super.key});
  @override
  State<SaldoScreen> createState() => _SaldoScreenState();
}

class _SaldoScreenState extends State<SaldoScreen> {
  final _amounts = [10000, 20000, 25000, 50000, 100000, 150000, 250000, 500000, 1000000];
  int _selected = 10000;

  Future<void> _proceed() async {
    final method = await Navigator.push<PaymentMethod>(
      context,
      MaterialPageRoute(builder: (_) => PaymentMethodScreen(amount: _selected)),
    );
    if (method == null) return;
    final total = _selected + method.fee;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nominal: Rp ${_selected}'),
            Text('Metode: ${method.name}'),
            if (method.fee > 0) Text('Biaya: Rp ${method.fee}'),
            const Divider(),
            Text('Total: Rp $total', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Bayar')),
        ],
      ),
    );
    if (confirm != true) return;
    final tx = await AppState.instance.topupSaldo(_selected, method.name);
    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ReceiptScreen(tx: tx)));
  }

  @override
  Widget build(BuildContext context) {
    final rupiah = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Scaffold(
      appBar: AppBar(title: const Text('Isi Saldo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nominal Dipilih', style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 4),
                Text(rupiah.format(_selected), style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Pilih Nominal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 3, shrinkWrap: true,
            crossAxisSpacing: 8, mainAxisSpacing: 8,
            childAspectRatio: 2.2,
            physics: const NeverScrollableScrollPhysics(),
            children: _amounts.map((a) {
              final active = a == _selected;
              return InkWell(
                onTap: () => setState(() => _selected = a),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: active ? const Color(0xFF1565C0).withOpacity(0.15) : const Color(0xFF151A21),
                    border: Border.all(color: active ? const Color(0xFF42A5F5) : const Color(0xFF232A33), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(rupiah.format(a), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: active ? const Color(0xFF42A5F5) : Colors.white)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: _proceed, child: const Text('Pilih Metode Pembayaran')),
        ],
      ),
    );
  }
}
