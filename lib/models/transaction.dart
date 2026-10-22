class Transaction {
  final String code;
  final String type; // 'game' atau 'saldo'
  final String gameName;
  final String gameId;
  final String userId;
  final String zoneId;
  final String item;
  final int price;
  final int balanceAfter;
  final DateTime createdAt;
  final String status;

  Transaction({
    required this.code,
    required this.type,
    required this.gameName,
    required this.gameId,
    required this.userId,
    required this.zoneId,
    required this.item,
    required this.price,
    required this.balanceAfter,
    required this.createdAt,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'code': code,
        'type': type,
        'gameName': gameName,
        'gameId': gameId,
        'userId': userId,
        'zoneId': zoneId,
        'item': item,
        'price': price,
        'balanceAfter': balanceAfter,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
      };

  factory Transaction.fromJson(Map<String, dynamic> j) => Transaction(
        code: j['code'],
        type: j['type'] ?? 'game',
        gameName: j['gameName'],
        gameId: j['gameId'] ?? '-',
        userId: j['userId'],
        zoneId: j['zoneId'] ?? '',
        item: j['item'],
        price: j['price'],
        balanceAfter: j['balanceAfter'] ?? 0,
        createdAt: DateTime.parse(j['createdAt']),
        status: j['status'] ?? 'success',
      );
}
