import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/app_state.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fakeUsers = [
      ('PlayerOne', 3200, '👑'),
      ('GameMaster', 2800, '🥈'),
      ('TopUpKing', 2400, '🥉'),
      ('ProGamer99', 2100, '🎮'),
      ('DiamondHunter', 1800, '💎'),
      ('MobileLegend', 1500, '⚔️'),
      (AppState.instance.userName, AppState.instance.xp, AppState.instance.avatar),
    ]..sort((a, b) => b.$2.compareTo(a.$2));

    return Scaffold(
      appBar: AppBar(title: const Text('Papan Peringkat')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: fakeUsers.length,
        itemBuilder: (context, i) {
          final u = fakeUsers[i];
          final isMe = u.$1 == AppState.instance.userName;
          return Card(
            color: isMe ? const Color(0xFFE3F2FD) : null,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isMe
                    ? const Color(0xFF1565C0)
                    : Colors.grey.shade200,
                child: Text(u.$3, style: const TextStyle(fontSize: 20)),
              ),
              title: Text(u.$1,
                  style: TextStyle(
                      fontWeight:
                          isMe ? FontWeight.bold : FontWeight.normal)),
              subtitle: Text('XP: ${u.$2}'),
              trailing: i < 3
                  ? Text(['🥇', '🥈', '🥉'][i],
                      style: const TextStyle(fontSize: 24))
                  : Text('#${i + 1}',
                      style: TextStyle(color: Colors.grey.shade600)),
            ),
          ).animate().fadeIn(delay: (i * 80).ms);
        },
      ),
    );
  }
}
