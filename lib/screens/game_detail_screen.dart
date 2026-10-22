import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/game.dart';
import '../models/transaction.dart';
import '../data/vouchers.dart';
import '../services/app_state.dart';
import 'receipt_screen.dart';
import 'saldo_screen.dart';

class GameDetailScreen extends StatefulWidget {
  final Game game;
  const GameDetailScreen({super.key, required this.game});
  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  final _idController = TextEditingController();
  final _zoneController = TextEditingController();
  final _voucherController = TextEditingController();
  Denom? _denom;
  Voucher? _voucher;
  bool _loading = false;

  final _rupiah =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  int get _subtotal => _denom?.price ?? 0;
  int get _discount => _voucher?.calculate(_subtotal) ?? 0;
  int get _total => _subtotal - _discount;

  void _applyVoucher() {
    final code = _voucherController.text.trim();
    if (code.isEmpty) return;
    if (AppState.instance.usedVouchers.contains(code.toUpperCase())) {
      _snack('Voucher sudah pernah digunakan');
      return;
    }
    final v = findVoucher(code);
    if (v == null) return _snack('Kode voucher tidak ditemukan');
    if (_denom == null) return _snack('Pilih nominal dulu');
    if (_subtotal < v.minSpend) {
      return _snack('Min. transaksi ${_rupiah.format(v.minSpend)}');
    }
    setState(() => _voucher = v);
    _snack('Voucher ${v.code} aktif');
  }

  Future<void> _pay() async {
    final id = _idController.text.trim();
    if (id.length < 4) return _snack('User ID minimal 4 digit');
    if (_denom == null) return _snack('Pilih nominal dulu');

    final state = AppState.instance;
    if (state.balance < _total) {
      final go = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Saldo Kurang'),
          content: Text('Butuh ${_rupiah.format(_total)}, '
              'saldo Anda ${_rupiah.format(state.balance)}.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal')),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Isi Saldo')),
          ],
        ),
      );
      if (go == true && mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const SaldoScreen()));
      }
      return;
    }

    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    final tx = await state.spendForGame(
      game: widget.game,
      denom: _denom!,
      userId: id,
      zoneId: _zoneController.text.trim(),
      discount: _discount,
      voucherCode: _voucher?.code ?? '',
    );
    if (!mounted) return;
    setState(() => _loading = false);
    if (tx != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ReceiptScreen(tx: tx)));
    } else {
      _snack('Transaksi gagal');
    }
  }

  void _snack(String m) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final balance = AppState.instance.balance;
        return Scaffold(
          appBar: AppBar(title: Text(widget.game.name)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGameHeader(),
                const SizedBox(height: 16),
                _buildBalanceCard(balance),
                const SizedBox(height: 16),
                TextField(
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'User ID',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _zoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Zone ID (opsional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.tag),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Pilih Nominal',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...widget.game.denominations.map(_buildDenomCard),
                const SizedBox(height: 20),
                const Text('Kode Voucher',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _voucherController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan kode',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.local_offer),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _applyVoucher,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        backgroundColor: const Color(0xFF1565C0),
                      ),
                      child: const Text('Pakai',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                if (_voucher != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                              '${_voucher!.code} — ${_voucher!.description}',
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 12)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () => setState(() => _voucher = null),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                _buildTotalCard(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loading ? null : _pay,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: const Color(0xFF1565C0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : const Text('Bayar dengan Saldo',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGameHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              widget.game.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (c, e, s) => Center(
                child: Text(widget.game.emoji,
                    style: const TextStyle(fontSize: 32)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.game.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text('${widget.game.publisher} · ${widget.game.category}',
                    style: TextStyle(
                        color: Colors.grey.shade700, fontSize: 12)),
                Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text('${widget.game.rating}',
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(int balance) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet,
              color: Colors.green.shade800, size: 20),
          const SizedBox(width: 8),
          Text('Saldo: ${_rupiah.format(balance)}',
              style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildDenomCard(Denom d) {
    final active = _denom == d;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: active ? const Color(0xFFE3F2FD) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: active ? const Color(0xFF1565C0) : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => setState(() {
          _denom = d;
          _voucher = null;
        }),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(d.label,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        if (d.tag != null) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: d.tag == 'HOT'
                                  ? Colors.red
                                  : d.tag == 'PROMO'
                                      ? Colors.orange
                                      : Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(d.tag!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ],
                    ),
                    if (d.originalPrice != null) ...[
                      const SizedBox(height: 2),
                      Text(_rupiah.format(d.originalPrice),
                          style: const TextStyle(
                              fontSize: 11,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey)),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_rupiah.format(d.price),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1565C0))),
                  if (d.originalPrice != null)
                    Text('Hemat ${_rupiah.format(d.discount)}',
                        style: const TextStyle(
                            fontSize: 10, color: Colors.green)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _row('Subtotal', _rupiah.format(_subtotal)),
          if (_discount > 0)
            _row('Diskon', '- ${_rupiah.format(_discount)}',
                color: Colors.green),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(_rupiah.format(_total),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {Color? color}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: Colors.grey.shade700)),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: color ?? Colors.black87)),
          ],
        ),
      );
}
