class Denom {
  final String label;
  final int price;
  final String? tag;
  final int? originalPrice;
  const Denom(this.label, this.price, {this.tag, this.originalPrice});
  int get discount => originalPrice == null ? 0 : originalPrice! - price;
}

class Game {
  final String id, name, publisher, category, emoji, domain;
  final bool isPopular;
  final double rating;
  final List<Denom> denominations;
  const Game({
    required this.id,
    required this.name,
    required this.publisher,
    required this.category,
    required this.emoji,
    required this.domain,
    required this.isPopular,
    required this.rating,
    required this.denominations,
  });
  String get imageUrl => 'https://www.google.com/s2/favicons?domain=$domain&sz=128';
  int get cheapest => denominations.map((d) => d.price).reduce((a, b) => a < b ? a : b);
}
