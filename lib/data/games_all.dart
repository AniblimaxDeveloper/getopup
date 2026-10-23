import '../models/game.dart';
import 'dummy_games.dart' as base;
import 'games_extra.dart';

final List<Game> allGames = [...base.games, ...extraGames];
final List<Game> allPopular = allGames.where((g) => g.isPopular).toList();

List<Game> searchAll(String q) {
  if (q.isEmpty) return allGames;
  final s = q.toLowerCase();
  return allGames.where((g) =>
    g.name.toLowerCase().contains(s) || g.publisher.toLowerCase().contains(s)
  ).toList();
}
