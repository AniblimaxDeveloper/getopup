import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/app_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final items = AppState.instance.notifications;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Notifikasi'),
            actions: [
              if (items.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => AppState.instance.clearNotifications(),
                ),
            ],
          ),
          body: items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_none,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      const Text('Belum ada notifikasi',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final n = items[i];
                    final icon = n.type == 'reward'
                        ? Icons.card_giftcard
                        : n.type == 'success'
                            ? Icons.check_circle
                            : Icons.info;
                    final color = n.type == 'reward'
                        ? Colors.orange
                        : n.type == 'success'
                            ? Colors.green
                            : Colors.blue;
                    return Card(
                      color: n.read ? null : color.withOpacity(0.05),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: color.withOpacity(0.15),
                          child: Icon(icon, color: color, size: 20),
                        ),
                        title: Text(n.title,
                            style: TextStyle(
                              fontWeight: n.read
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              fontSize: 14,
                            )),
                        subtitle: Text(
                          '${n.message}\n${DateFormat('dd MMM HH:mm').format(n.createdAt)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
