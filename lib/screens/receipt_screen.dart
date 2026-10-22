import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class ReceiptScreen extends StatelessWidget {
  final Transaction tx;
  const ReceiptScreen({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final date = DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(tx.createdAt);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bukti Transaksi'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle,
                      color: Colors.green, size: 64),
                  const SizedBox(height: 8),
                  const Text('Transaksi Berhasil',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(tx.code,
                      style: TextStyle(color: Colors.grey.shade700)),
                  const Divider(height: 32),
                  _row('Tanggal', date),
                  _row('Jenis',
                      tx.type == 'saldo' ? 'Isi Saldo' : 'Top Up Game'),
                  if (tx.type == 'game') ...[
                    _row('Game', tx.gameName),
                    _row('User ID', tx.userId),
                    if (tx.zoneId.isNotEmpty) _row('Zone ID', tx.zoneId),
                    _row('Item', tx.item),
                  ] else
                    _row('Metode', tx.item),
                  _row('Total', rupiah.format(tx.price)),
                  _row('Sisa Saldo', rupiah.format(tx.balanceAfter)),
                  _row('Status', tx.status.toUpperCase()),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      final text = 'Kode: ${tx.code}\n'
                          'Tanggal: $date\n'
                          'Item: ${tx.item}\n'
                          'Total: ${rupiah.format(tx.price)}\n'
                          'Status: ${tx.status}';
                      Clipboard.setData(ClipboardData(text: text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Bukti disalin ke clipboard')),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Salin Bukti'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(
                    context, (route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Selesai',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              child: Text(label,
                  style: TextStyle(color: Colors.grey.shade600)),
            ),
            Expanded(
              child: Text(value,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
}
