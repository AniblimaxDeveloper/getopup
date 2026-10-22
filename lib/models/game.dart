class Denom {
  final String label;
  final int price;
  final String? tag; // 'HOT', 'PROMO', 'BEST'
  const Denom(this.label, this.price, {this.tag});
}

class Game {
  final String id;
  final String name;
  final String publisher;
  final String category;
  final String emoji;
  final List<Denom> denominations;
  const Game({
    required this.id,
    required this.name,
    required this.publisher,
    required this.category,
    required this.emoji,
    required this.denominations,
  });
}
