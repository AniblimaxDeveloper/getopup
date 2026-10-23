import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../services/app_state.dart';
import 'receipt_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _filter = 'Semua';

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final all = AppState.instance.history;
        final items = _filter == 'Semua'
            ? all
            : all
                .where((t) =>
                    (_filter == 'Top Up' && t.type == 'game') ||
                    (_filter == 'Isi Saldo' && t.type == 'saldo'))
                .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Riwayat Transaksi'),
            actions: [
              if (all.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.ios_share),
                  tooltip: 'Ekspor',
                  onPressed: () {
                    final buffer = StringBuffer();
                    buffer.writeln('=== Riwayat GeTopUp ===');
                    for (final t in all) {
                      buffer.writeln(
                          '${DateFormat('dd/MM/yyyy HH:mm').format(t.createdAt)} | ${t.gameName} | ${t.item} | ${rupiah.format(t.total)} | ${t.code}');
                    }
                    Clipboard.setData(ClipboardData(text: buffer.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              '${all.length} transaksi disalin ke clipboard')),
                    );
                  },
                ),
            ],
          ),
          body: all.isEmpty
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
              : Column(
                  children: [
                    SizedBox(
                      height: 48,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        children: ['Semua', 'Top Up', 'Isi Saldo'].map((f) {
                          final active = f == _filter;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: ChoiceChip(
                              label: Text(f),
                              selected: active,
                              onSelected: (_) =>
                                  setState(() => _filter = f),
                              selectedColor: const Color(0xFF1565C0),
                              labelStyle: TextStyle(
                                color: active ? Colors.white : null,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
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
                                    builder: (_) =>
                                        ReceiptScreen(tx: t)),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: isSaldo
                                    ? Colors.green.shade100
                                    : const Color(0xFFE3F2FD),
                                child: Icon(
                                  isSaldo
                                      ? Icons.add
                                      : Icons.sports_esports,
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
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
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
                    ),
                  ],
                ),
        );
      },
    );
  }
}
