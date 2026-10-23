import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/payment_method.dart';

class PaymentMethodScreen extends StatefulWidget {
  final int amount;
  const PaymentMethodScreen({super.key, required this.amount});
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    final rupiah = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final groups = <String, List<PaymentMethod>>{};
    for (final m in paymentMethods) {
      groups.putIfAbsent(m.group, () => []).add(m);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Pembayaran')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Pembayaran', style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 4),
                Text(rupiah.format(widget.amount), style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...groups.entries.map((e) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 12, 4, 6),
                child: Text(e.key, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF9AA0A6))),
              ),
              ...e.value.map((m) {
                final active = _selectedId == m.id;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => setState(() => _selectedId = m.id),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: active ? const Color(0xFF1565C0).withOpacity(0.15) : const Color(0xFF151A21),
                        border: Border.all(color: active ? const Color(0xFF42A5F5) : const Color(0xFF232A33), width: active ? 2 : 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(color: m.color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                            child: Icon(m.icon, color: m.color, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              if (m.fee > 0)
                                Text('+ ${rupiah.format(m.fee)}', style: const TextStyle(fontSize: 10, color: Colors.orange)),
                            ],
                          )),
                          Radio<String>(value: m.id, groupValue: _selectedId, onChanged: (v) => setState(() => _selectedId = v!)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          )),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF0F1318),
          border: Border(top: BorderSide(color: Color(0xFF232A33))),
        ),
        child: SafeArea(
          top: false,
          child: ElevatedButton(
            onPressed: _selectedId == null ? null : () {
              final m = paymentMethods.firstWhere((x) => x.id == _selectedId);
              Navigator.pop(context, m);
            },
            child: const Text('Lanjutkan'),
          ),
        ),
      ),
    );
  }
}
