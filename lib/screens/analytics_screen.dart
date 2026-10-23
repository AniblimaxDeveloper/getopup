import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/app_state.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final history = AppState.instance.history;
        final now = DateTime.now();
        final last7 = List.generate(7, (i) {
          final day = now.subtract(Duration(days: 6 - i));
          final total = history
              .where((t) =>
                  t.createdAt.year == day.year &&
                  t.createdAt.month == day.month &&
                  t.createdAt.day == day.day)
              .fold<int>(0, (s, t) => s + t.total);
          return MapEntry(day, total);
        });
        final totalWeek = last7.fold<int>(0, (s, e) => s + e.value);
        final totalAll =
            history.fold<int>(0, (s, t) => s + t.total);
        final gameSpend =
            history.where((t) => t.type == 'game').fold<int>(0, (s, t) => s + t.total);
        final saldoSpend =
            history.where((t) => t.type == 'saldo').fold<int>(0, (s, t) => s + t.total);
        final maxVal = last7.map((e) => e.value).fold<int>(1, (a, b) => a > b ? a : b);

        return Scaffold(
          appBar: AppBar(title: const Text('Analitik')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(
                      child: _statCard('Total', rupiah.format(totalAll),
                          Icons.summarize, Colors.blue)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _statCard('7 Hari',
                          rupiah.format(totalWeek),
                          Icons.calendar_today,
                          Colors.green)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: _statCard('Top Up', rupiah.format(gameSpend),
                          Icons.sports_esports, Colors.orange)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _statCard('Isi Saldo',
                          rupiah.format(saldoSpend), Icons.wallet,
                          Colors.purple)),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pengeluaran 7 Hari Terakhir',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 160,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: last7.map((e) {
                          final height =
                              (e.value / maxVal) * 130 + (e.value > 0 ? 10 : 0);
                          return Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(rupiah.format(e.value),
                                      style: const TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Container(
                                    height: height,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF1565C0),
                                          Color(0xFF42A5F5),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat('E', 'id_ID')
                                        .format(e.key),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold)),
          Text(label,
              style: TextStyle(
                  color: Colors.grey.shade600, fontSize: 11)),
        ],
      ),
    );
  }
}
