import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/dummy_games.dart';
import '../services/app_state.dart';
import 'game_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final favs = games
            .where((g) => AppState.instance.isFavorite(g.id))
            .toList();
        return Scaffold(
          appBar: AppBar(title: const Text('Game Favorit')),
          body: favs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      const Text('Belum ada favorit',
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text('Tap ikon bintang di halaman game',
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 12)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: favs.length,
                  itemBuilder: (context, i) {
                    final g = favs[i];
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
                          child: Image.network(g.imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (c, e, s) => Center(
                                  child: Text(g.emoji,
                                      style:
                                          const TextStyle(fontSize: 20)))),
                        ),
                        title: Text(g.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        subtitle: Text('${g.publisher} · ${g.category}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(rupiah.format(g.cheapest),
                                style: const TextStyle(
                                    color: Color(0xFF1565C0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            IconButton(
                              icon: const Icon(Icons.star,
                                  color: Colors.amber),
                              onPressed: () =>
                                  AppState.instance.toggleFavorite(g.id),
                            ),
                          ],
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => GameDetailScreen(game: g)),
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
