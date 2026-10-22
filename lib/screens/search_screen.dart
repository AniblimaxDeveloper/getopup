import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/dummy_games.dart';
import '../models/game.dart';
import 'game_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<Game> _results = games;

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: (v) => setState(() => _results = searchGames(v)),
          decoration: const InputDecoration(
            hintText: 'Cari game atau publisher...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: _results.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('Tidak ditemukan',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _results.length,
              itemBuilder: (context, i) {
                final g = _results[i];
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
                      child: Image.network(
                        g.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Center(
                          child: Text(g.emoji,
                              style: const TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                    title: Text(g.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${g.publisher} · ${g.category}'),
                    trailing: Text(rupiah.format(g.cheapest),
                        style: const TextStyle(
                            color: Color(0xFF1565C0),
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
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
  }
}
