import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/game.dart';
import '../data/vouchers.dart';
import '../services/app_state.dart';
import 'receipt_screen.dart';
import 'saldo_screen.dart';

class TopupScreen extends StatefulWidget {
  final Game game;
  const TopupScreen({super.key, required this.game});
  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
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
    if (v == null) {
      _snack('Kode voucher tidak ditemukan');
      return;
    }
    if (_denom == null) {
      _snack('Pilih nominal terlebih dahulu');
      return;
    }
    if (_subtotal < v.minSpend) {
      _snack('Minimal transaksi ${_rupiah.format(v.minSpend)}');
      return;
    }
    setState(() => _voucher = v);
    _snack('Voucher ${v.code} berhasil digunakan');
  }

  Future<void> _confirm() async {
    final id = _idController.text.trim();
    if (id.length < 4) return _snack('User ID minimal 4 digit');
    if (_denom == null) return _snack('Pilih nominal terlebih dahulu');

    final state = AppState.instance;
    if (state.balance < _total) {
      final go = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Saldo Kurang'),
          content: Text('Saldo ${_rupiah.format(state.balance)}, '
              'dibutuhkan ${_rupiah.format(_total)}.'),
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

  void _snack(String m) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(m)));

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
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade100, Colors.blue.shade200],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(widget.game.emoji,
                          style: const TextStyle(fontSize: 28)),
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
                                  color: Colors.grey.shade600, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
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
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'User ID',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
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
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Pilih Nominal',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...widget.game.denominations.map((d) {
                  final active = _denom == d;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 6),
                    color: active ? Colors.blue.shade50 : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: active ? Colors.blueAccent : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      onTap: () => setState(() {
                        _denom = d;
                        _voucher = null;
                      }),
                      title: Text(d.label),
                      subtitle: d.tag != null
                          ? Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: d.tag == 'HOT'
                                    ? Colors.red.shade100
                                    : Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(d.tag!,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: d.tag == 'HOT'
                                          ? Colors.red.shade800
                                          : Colors.orange.shade900,
                                      fontWeight: FontWeight.bold)),
                            )
                          : null,
                      trailing: Text(
                        _rupiah.format(d.price),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  );
                }),
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
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _applyVoucher,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        backgroundColor: Colors.blueAccent,
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
                        Icon(Icons.check_circle,
                            color: Colors.green.shade600, size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text('${_voucher!.code} — ${_voucher!.description}',
                              style: TextStyle(
                                  color: Colors.green.shade700, fontSize: 12)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () => setState(() => _voucher = null),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _summaryRow('Subtotal', _rupiah.format(_subtotal)),
                      if (_discount > 0)
                        _summaryRow('Diskon', '- ${_rupiah.format(_discount)}',
                            color: Colors.green),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            _rupiah.format(_total),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loading ? null : _confirm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : const Text('Bayar dengan Saldo',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _summaryRow(String label, String value, {Color? color}) {
    return Padding(
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
}
