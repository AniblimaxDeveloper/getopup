import 'dart:convert';

class Transaction {
  final String id;
  final String gameName;
  final String userId;
  final String zoneId;
  final String item;
  final int amount;
  final DateTime createdAt;
  final String status;

  Transaction({
    required this.id,
    required this.gameName,
    required this.userId,
    required this.zoneId,
    required this.item,
    required this.amount,
    required this.createdAt,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'gameName': gameName,
        'userId': userId,
        'zoneId': zoneId,
        'item': item,
        'amount': amount,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
      };

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        gameName: json['gameName'],
        userId: json['userId'],
        zoneId: json['zoneId'] ?? '',
        item: json['item'],
        amount: json['amount'],
        createdAt: DateTime.parse(json['createdAt']),
        status: json['status'],
      );

  static String encodeList(List<Transaction> list) =>
      jsonEncode(list.map((t) => t.toJson()).toList());

  static List<Transaction> decodeList(String str) {
    final data = jsonDecode(str) as List;
    return data.map((e) => Transaction.fromJson(e)).toList();
  }
}
