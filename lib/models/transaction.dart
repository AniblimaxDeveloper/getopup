class Transaction {
  final String code;
  final String type;
  final String gameName;
  final String gameId;
  final String userId;
  final String zoneId;
  final String item;
  final int subtotal;
  final int discount;
  final String voucherCode;
  final int total;
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
    required this.subtotal,
    required this.discount,
    required this.voucherCode,
    required this.total,
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
        'subtotal': subtotal,
        'discount': discount,
        'voucherCode': voucherCode,
        'total': total,
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
        subtotal: j['subtotal'] ?? j['price'] ?? 0,
        discount: j['discount'] ?? 0,
        voucherCode: j['voucherCode'] ?? '',
        total: j['total'] ?? j['price'] ?? 0,
        balanceAfter: j['balanceAfter'] ?? 0,
        createdAt: DateTime.parse(j['createdAt']),
        status: j['status'] ?? 'success',
      );
}
