import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game.dart';
import '../models/transaction.dart';

class AppState extends ChangeNotifier {
  static final AppState instance = AppState._();
  AppState._();

  int _balance = 0;
  List<Transaction> _history = [];
  String _userName = 'Player';
  final Set<String> _usedVouchers = {};
  bool _loaded = false;

  int get balance => _balance;
  List<Transaction> get history => List.unmodifiable(_history);
  String get userName => _userName;
  bool get loaded => _loaded;
  Set<String> get usedVouchers => Set.unmodifiable(_usedVouchers);

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    _balance = p.getInt('balance') ?? 0;
    _userName = p.getString('userName') ?? 'Player';
    _usedVouchers.addAll(p.getStringList('usedVouchers') ?? []);
    final raw = p.getString('history');
    if (raw != null && raw.isNotEmpty) {
      try {
        _history = (jsonDecode(raw) as List)
            .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {
        _history = [];
      }
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> _persist() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('balance', _balance);
    await p.setString('userName', _userName);
    await p.setStringList('usedVouchers', _usedVouchers.toList());
    await p.setString('history',
        jsonEncode(_history.map((t) => t.toJson()).toList()));
  }

  Future<Transaction> topupSaldo(int amount, String method) async {
    _balance += amount;
    final tx = Transaction(
      code: _genCode('SALDO'),
      type: 'saldo',
      gameName: 'Isi Saldo',
      gameId: '-',
      userId: _userName,
      zoneId: '',
      item: method,
      subtotal: amount,
      discount: 0,
      voucherCode: '',
      total: amount,
      balanceAfter: _balance,
      createdAt: DateTime.now(),
      status: 'success',
    );
    _history.insert(0, tx);
    await _persist();
    notifyListeners();
    return tx;
  }

  Future<Transaction?> spendForGame({
    required Game game,
    required Denom denom,
    required String userId,
    required String zoneId,
    required int discount,
    required String voucherCode,
  }) async {
    final total = denom.price - discount;
    if (total < 0) return null;
    if (_balance < total) return null;
    _balance -= total;
    if (voucherCode.isNotEmpty) _usedVouchers.add(voucherCode);

    final tx = Transaction(
      code: _genCode('GTU'),
      type: 'game',
      gameName: game.name,
      gameId: game.id,
      userId: userId,
      zoneId: zoneId,
      item: denom.label,
      subtotal: denom.price,
      discount: discount,
      voucherCode: voucherCode,
      total: total,
      balanceAfter: _balance,
      createdAt: DateTime.now(),
      status: 'success',
    );
    _history.insert(0, tx);
    await _persist();
    notifyListeners();
    return tx;
  }

  Future<void> setUserName(String name) async {
    _userName = name.trim().isEmpty ? 'Player' : name.trim();
    await _persist();
    notifyListeners();
  }

  Future<void> clearAll() async {
    _balance = 0;
    _history = [];
    _userName = 'Player';
    _usedVouchers.clear();
    await _persist();
    notifyListeners();
  }

  String _genCode(String prefix) {
    final r = Random();
    final n = List.generate(8, (_) => r.nextInt(10)).join();
    return '$prefix-$n';
  }
}
