import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/app_state.dart';
import 'receipt_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final items = AppState.instance.history;
        return Scaffold(
          appBar: AppBar(title: const Text('Riwayat Transaksi')),
          body: items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      const Text('Belum ada transaksi',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final t = items[i];
                    final isSaldo = t.type == 'saldo';
                    return Card(
                      child: ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ReceiptScreen(tx: t)),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: isSaldo
                              ? Colors.green.shade100
                              : const Color(0xFFE3F2FD),
                          child: Icon(
                            isSaldo ? Icons.add : Icons.sports_esports,
                            color: isSaldo
                                ? Colors.green.shade800
                                : const Color(0xFF1565C0),
                          ),
                        ),
                        title: Text(
                          isSaldo
                              ? 'Isi Saldo ${t.item}'
                              : '${t.gameName} — ${t.item}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        subtitle: Text(
                          '${DateFormat('dd MMM yyyy HH:mm').format(t.createdAt)}\n${t.code}',
                          style: const TextStyle(fontSize: 11),
                        ),
                        isThreeLine: true,
                        trailing: Text(
                          '${isSaldo ? '+' : '-'} ${rupiah.format(t.total)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSaldo
                                ? Colors.green
                                : const Color(0xFF1565C0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
