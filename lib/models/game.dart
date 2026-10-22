class Denom {
  final String label;
  final int price;
  const Denom(this.label, this.price);
}

class Game {
  final String id;
  final String name;
  final String emoji;
  final List<Denom> denominations;
  const Game({
    required this.id,
    required this.name,
    required this.emoji,
    required this.denominations,
  });
}
