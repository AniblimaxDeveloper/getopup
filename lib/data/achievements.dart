class Achievement {
  final String id;
  final String emoji;
  final String title;
  final String description;
  final int target;
  const Achievement({
    required this.id,
    required this.emoji,
    required this.title,
    required this.description,
    required this.target,
  });
}

final List<Achievement> achievements = [
  const Achievement(
    id: 'first',
    emoji: '🎯',
    title: 'Langkah Pertama',
    description: 'Selesaikan 1 transaksi top up',
    target: 1,
  ),
  const Achievement(
    id: 'five',
    emoji: '🔥',
    title: 'Pemula Handal',
    description: 'Selesaikan 5 transaksi top up',
    target: 5,
  ),
  const Achievement(
    id: 'ten',
    emoji: '⭐',
    title: 'Pro Player',
    description: 'Selesaikan 10 transaksi top up',
    target: 10,
  ),
  const Achievement(
    id: 'twenty',
    emoji: '💎',
    title: 'Veteran',
    description: 'Selesaikan 20 transaksi top up',
    target: 20,
  ),
  const Achievement(
    id: 'fifty',
    emoji: '👑',
    title: 'Legenda GeTopUp',
    description: 'Selesaikan 50 transaksi top up',
    target: 50,
  ),
];
