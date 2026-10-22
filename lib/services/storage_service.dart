import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';

class StorageService {
  static const _keyHistory = 'transactions';

  static Future<List<Transaction>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyHistory);
    if (raw == null || raw.isEmpty) return [];
    try {
      return Transaction.decodeList(raw);
    } catch (_) {
      return [];
    }
  }

  static Future<void> saveTransaction(Transaction tx) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadHistory();
    existing.insert(0, tx);
    final trimmed = existing.take(100).toList();
    await prefs.setString(_keyHistory, Transaction.encodeList(trimmed));
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHistory);
  }
}
