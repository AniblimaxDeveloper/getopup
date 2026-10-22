import 'package:flutter/material.dart';
import '../data/achievements.dart';
import '../services/app_state.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final count = AppState.instance.gameTxCount;
        final unlocked =
            achievements.where((a) => count >= a.target).length;
        return Scaffold(
          appBar: AppBar(title: const Text('Pencapaian')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emoji_events,
                        color: Colors.white, size: 48),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Pencapaian',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('$unlocked / ${achievements.length} terbuka',
                              style:
                                  const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text('Total top up: $count',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ...achievements.map((a) {
                final done = count >= a.target;
                final progress =
                    (count / a.target).clamp(0.0, 1.0).toDouble();
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: done
                                    ? Colors.amber.withOpacity(0.2)
                                    : Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(a.emoji,
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: done
                                            ? null
                                            : Colors.grey)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(a.title,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: done
                                            ? null
                                            : Colors.grey.shade600,
                                      )),
                                  Text(a.description,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                            if (done)
                              const Icon(Icons.check_circle,
                                  color: Colors.green),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor: Colors.grey.shade200,
                            color: done ? Colors.green : Colors.amber,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('$count / ${a.target}',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
