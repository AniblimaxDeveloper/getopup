import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/dummy_games.dart';
import '../services/app_state.dart';
import 'game_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final wishlist = AppState.instance.wishlist;
        final items = <MapEntry>[];
        for (final key in wishlist) {
          final parts = key.split('|');
          if (parts.length != 2) continue;
          final game = games.firstWhere((g) => g.id == parts[0],
              orElse: () => games[0]);
          final denom = game.denominations
              .where((d) => d.label == parts[1])
              .toList();
          if (denom.isNotEmpty) {
            items.add(MapEntry(game, denom.first));
          }
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Wishlist Harga')),
          body: items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      const Text('Wishlist kosong',
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text('Tap ikon hati di detail game',
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 12)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final entry = items[i];
                    final game = entry.key;
                    final denom = entry.value;
                    return Card(
                      child: ListTile(
                        leading: Container(
                          width: 44,
                          height: 44,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.network(game.imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (c, e, s) => Center(
                                  child: Text(game.emoji,
                                      style:
                                          const TextStyle(fontSize: 20)))),
                        ),
                        title: Text(game.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(denom.label),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(rupiah.format(denom.price),
                                style: const TextStyle(
                                    color: Color(0xFF1565C0),
                                    fontWeight: FontWeight.bold)),
                            if (denom.tag != null)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(denom.tag!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold)),
                              ),
                          ],
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  GameDetailScreen(game: game)),
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
