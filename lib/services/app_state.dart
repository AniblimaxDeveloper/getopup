import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game.dart';
import '../models/transaction.dart';
import '../models/notification.dart';

class AppState extends ChangeNotifier {
  static final AppState instance = AppState._();
  AppState._();

  int _balance = 0;
  List<Transaction> _history = [];
  String _userName = 'Player';
  String _userEmail = '';
  String _loginMethod = 'guest';
  String _avatar = '😀';
  String _bio = 'Top up game setiap hari!';
  String _referralCode = '';
  DateTime _joinDate = DateTime.now();
  int _xp = 0;
  final Set<String> _usedVouchers = {};
  bool _onboardingDone = false;
  bool _loaded = false;
  bool _darkMode = false;
  String _language = 'id';
  double _fontScale = 1.0;
  bool _notifEnabled = true;
  String? _pinHash;
  bool _loggedIn = false;
  final List<String> _favorites = [];
  DateTime? _lastCheckIn;
  List<AppNotification> _notifications = [];

  int get balance => _balance;
  List<Transaction> get history => List.unmodifiable(_history);
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get loginMethod => _loginMethod;
  String get avatar => _avatar;
  String get bio => _bio;
  String get referralCode => _referralCode;
  DateTime get joinDate => _joinDate;
  int get xp => _xp;
  bool get loaded => _loaded;
  bool get onboardingDone => _onboardingDone;
  Set<String> get usedVouchers => Set.unmodifiable(_usedVouchers);
  bool get darkMode => _darkMode;
  String get language => _language;
  double get fontScale => _fontScale;
  bool get notifEnabled => _notifEnabled;
  bool get hasPin => _pinHash != null;
  bool get loggedIn => _loggedIn;
  List<String> get favorites => List.unmodifiable(_favorites);
  List<AppNotification> get notifications => List.unmodifiable(_notifications);
  int get unreadCount => _notifications.where((n) => !n.read).length;
  int get gameTxCount => _history.where((t) => t.type == 'game').length;

  int get level => (_xp / 100).floor() + 1;
  int get xpInLevel => _xp % 100;
  String get rank {
    if (_xp >= 1000) return 'Legenda';
    if (_xp >= 500) return 'Master';
    if (_xp >= 200) return 'Pro';
    if (_xp >= 100) return 'Ahli';
    return 'Pemula';
  }

  bool get canCheckIn {
    if (_lastCheckIn == null) return true;
    final now = DateTime.now();
    final last = _lastCheckIn!;
    return !(now.year == last.year &&
        now.month == last.month &&
        now.day == last.day);
  }

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    _balance = p.getInt('balance') ?? 0;
    _userName = p.getString('userName') ?? 'Player';
    _userEmail = p.getString('userEmail') ?? '';
    _loginMethod = p.getString('loginMethod') ?? 'guest';
    _avatar = p.getString('avatar') ?? '😀';
    _bio = p.getString('bio') ?? 'Top up game setiap hari!';
    _referralCode = p.getString('referralCode') ?? '';
    final jd = p.getString('joinDate');
    _joinDate = jd != null ? DateTime.tryParse(jd) ?? DateTime.now() : DateTime.now();
    if (_referralCode.isEmpty) _referralCode = _genReferral();
    _xp = p.getInt('xp') ?? 0;
    _onboardingDone = p.getBool('onboardingDone') ?? false;
    _darkMode = p.getBool('darkMode') ?? false;
    _language = p.getString('language') ?? 'id';
    _fontScale = p.getDouble('fontScale') ?? 1.0;
    _notifEnabled = p.getBool('notifEnabled') ?? true;
    _pinHash = p.getString('pinHash');
    _usedVouchers.addAll(p.getStringList('usedVouchers') ?? []);
    _favorites.addAll(p.getStringList('favorites') ?? []);
    final lastCi = p.getString('lastCheckIn');
    if (lastCi != null) _lastCheckIn = DateTime.tryParse(lastCi);

    final rawHistory = p.getString('history');
    if (rawHistory != null && rawHistory.isNotEmpty) {
      try {
        _history = (jsonDecode(rawHistory) as List)
            .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {
        _history = [];
      }
    }
    final rawNotif = p.getString('notifications');
    if (rawNotif != null && rawNotif.isNotEmpty) {
      try {
        _notifications = (jsonDecode(rawNotif) as List)
            .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {
        _notifications = [];
      }
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> _persist() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('balance', _balance);
    await p.setString('userName', _userName);
    await p.setString('userEmail', _userEmail);
    await p.setString('loginMethod', _loginMethod);
    await p.setString('avatar', _avatar);
    await p.setString('bio', _bio);
    await p.setString('referralCode', _referralCode);
    await p.setString('joinDate', _joinDate.toIso8601String());
    await p.setInt('xp', _xp);
    await p.setBool('onboardingDone', _onboardingDone);
    await p.setBool('darkMode', _darkMode);
    await p.setString('language', _language);
    await p.setDouble('fontScale', _fontScale);
    await p.setBool('notifEnabled', _notifEnabled);
    if (_pinHash != null) await p.setString('pinHash', _pinHash!);
    await p.setStringList('usedVouchers', _usedVouchers.toList());
    await p.setStringList('favorites', _favorites);
    if (_lastCheckIn != null) {
      await p.setString('lastCheckIn', _lastCheckIn!.toIso8601String());
    }
    await p.setString(
        'history', jsonEncode(_history.map((t) => t.toJson()).toList()));
    await p.setString('notifications',
        jsonEncode(_notifications.map((n) => n.toJson()).toList()));
  }

  Future<void> completeOnboarding() async {
    _onboardingDone = true;
    await _persist();
    notifyListeners();
  }

  Future<void> loginWithGoogleMock(String email) async {
    _userEmail = email;
    _loginMethod = 'google';
    final name = email.contains('@') ? email.split('@').first : email;
    _userName = name.isEmpty ? 'Google User' : name;
    _loggedIn = true;
    await _persist();
    notifyListeners();
  }

  Future<void> loginAsGuest(String name) async {
    _userName = name.trim().isEmpty ? 'Guest' : name.trim();
    _loginMethod = 'guest';
    _userEmail = '';
    _loggedIn = true;
    await _persist();
    notifyListeners();
  }

  Future<void> setPin(String pin) async {
    _pinHash = _hashPin(pin);
    await _persist();
    notifyListeners();
  }

  bool verifyPin(String pin) => _pinHash == _hashPin(pin);

  void login() {
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }

  Future<void> setDarkMode(bool v) async {
    _darkMode = v;
    await _persist();
    notifyListeners();
  }

  Future<void> setLanguage(String v) async {
    _language = v;
    await _persist();
    notifyListeners();
  }

  Future<void> setFontScale(double v) async {
    _fontScale = v;
    await _persist();
    notifyListeners();
  }

  Future<void> setNotifEnabled(bool v) async {
    _notifEnabled = v;
    await _persist();
    notifyListeners();
  }

  Future<void> setAvatar(String v) async {
    _avatar = v;
    await _persist();
    notifyListeners();
  }

  Future<void> setBio(String v) async {
    _bio = v;
    await _persist();
    notifyListeners();
  }

  Future<void> toggleFavorite(String gameId) async {
    if (_favorites.contains(gameId)) {
      _favorites.remove(gameId);
    } else {
      _favorites.add(gameId);
    }
    await _persist();
    notifyListeners();
  }

  bool isFavorite(String gameId) => _favorites.contains(gameId);

  Future<int?> checkIn() async {
    if (!canCheckIn) return null;
    _lastCheckIn = DateTime.now();
    _balance += 500;
    _xp += 10;
    _addNotification('Daily Check-in',
        'Anda mendapat bonus Rp 500 dan 10 XP', 'reward');
    await _persist();
    notifyListeners();
    return 500;
  }

  void _addNotification(String title, String message, String type) {
    if (!_notifEnabled) return;
    _notifications.insert(
      0,
      AppNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        message: message,
        type: type,
        createdAt: DateTime.now(),
        read: false,
      ),
    );
    if (_notifications.length > 50) {
      _notifications = _notifications.take(50).toList();
    }
  }

  Future<void> markNotificationsRead() async {
    for (final n in _notifications) {
      n.read = true;
    }
    await _persist();
    notifyListeners();
  }

  Future<void> clearNotifications() async {
    _notifications.clear();
    await _persist();
    notifyListeners();
  }

  Future<Transaction> topupSaldo(int amount, String method) async {
    _balance += amount;
    _xp += (amount / 10000).floor();
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
    _addNotification('Isi Saldo Berhasil',
        'Rp $amount via $method. Saldo: Rp $_balance', 'success');
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
    _xp += 20;
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
    _addNotification(
        'Top Up ${game.name} Berhasil', '${denom.label} - Rp $total', 'success');
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
    _userEmail = '';
    _loginMethod = 'guest';
    _avatar = '😀';
    _bio = 'Top up game setiap hari!';
    _xp = 0;
    _usedVouchers.clear();
    _favorites.clear();
    _notifications.clear();
    _lastCheckIn = null;
    await _persist();
    notifyListeners();
  }

  String _genCode(String prefix) {
    final r = Random();
    return '$prefix-${List.generate(8, (_) => r.nextInt(10)).join()}';
  }

  String _genReferral() {
    final r = Random();
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    return List.generate(8, (_) => chars[r.nextInt(chars.length)]).join();
  }

  String _hashPin(String pin) {
    final bytes = utf8.encode('${pin}_getopup_v5_salt');
    return base64.encode(bytes);
  }
}
