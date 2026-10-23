import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/game.dart';
import '../data/vouchers.dart';
import '../services/app_state.dart';
import 'receipt_screen.dart';
import 'saldo_screen.dart';
import 'payment_method_screen.dart';
import '../models/payment_method.dart';

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
  String? _idError;
  bool _processing = false;

  final _rupiah =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  bool get _requiresZone =>
      widget.game.id == 'mlbb' || widget.game.id == 'hok';

  int get _subtotal => _denom?.price ?? 0;
  int get _discount => _voucher?.calculate(_subtotal) ?? 0;
  int get _total => _subtotal - _discount;

  @override
  void dispose() {
    _idController.dispose();
    _zoneController.dispose();
    _voucherController.dispose();
    super.dispose();
  }

  void _applyVoucher() {
    final code = _voucherController.text.trim();
    if (code.isEmpty) return _snack('Masukkan kode voucher');
    if (AppState.instance.usedVouchers.contains(code.toUpperCase())) {
      return _snack('Voucher sudah pernah digunakan');
    }
    final v = findVoucher(code);
    if (v == null) return _snack('Kode voucher tidak valid');
    if (_denom == null) return _snack('Pilih nominal terlebih dahulu');
    if (_subtotal < v.minSpend) {
      return _snack('Min. transaksi ${_rupiah.format(v.minSpend)}');
    }
    setState(() => _voucher = v);
    _snack('✓ Voucher ${v.code} berhasil dipakai');
  }

  Future<void> _pay() async {
    setState(() => _idError = null);
    final id = _idController.text.trim();
    if (id.isEmpty) {
      setState(() => _idError = 'User ID wajib diisi');
      return;
    }
    if (id.length < 4) {
      setState(() => _idError = 'User ID minimal 4 digit');
      return;
    }
    if (_denom == null) return _snack('Pilih nominal terlebih dahulu');
    if (_requiresZone && _zoneController.text.trim().isEmpty) {
      return _snack('Zone ID wajib diisi untuk game ini');
    }

    final state = AppState.instance;
    if (state.balance < _total) {
      final go = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Saldo Tidak Cukup'),
          content: Text(
              'Saldo Anda ${_rupiah.format(state.balance)}, '
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

    final confirm = await _showConfirm();
    if (confirm != true) return;

    final method = await Navigator.push<PaymentMethod>(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentMethodScreen(amount: _total),
      ),
    );
    if (method == null) return;

    await _runProcessing();

    final tx = await state.spendForGame(
      game: widget.game,
      denom: _denom!,
      userId: id,
      zoneId: _zoneController.text.trim(),
      discount: _discount,
      voucherCode: _voucher?.code ?? '',
    );
    if (!mounted) return;
    if (tx != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ReceiptScreen(tx: tx)));
    } else {
      _snack('Transaksi gagal. Coba lagi.');
    }
  }

  Future<bool?> _showConfirm() {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Pesanan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _confirmRow('Game', widget.game.name),
            _confirmRow('User ID', _idController.text.trim()),
            if (_zoneController.text.trim().isNotEmpty)
              _confirmRow('Zone ID', _zoneController.text.trim()),
            _confirmRow('Item', _denom!.label),
            const Divider(),
            if (_discount > 0)
              _confirmRow('Diskon', '- ${_rupiah.format(_discount)}',
                  color: Colors.green),
            _confirmRow('Total', _rupiah.format(_total),
                bold: true, color: const Color(0xFF42A5F5)),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Bayar Sekarang')),
        ],
      ),
    );
  }

  Widget _confirmRow(String label, String value,
      {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 80,
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF9AA0A6)))),
          Expanded(
            child: Text(value,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: bold ? FontWeight.bold : FontWeight.w600,
                    color: color)),
          ),
        ],
      ),
    );
  }

  Future<void> _runProcessing() async {
    setState(() => _processing = true);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _ProcessingDialog(),
    );
    await Future.delayed(const Duration(milliseconds: 2400));
    if (mounted) Navigator.pop(context);
    if (mounted) setState(() => _processing = false);
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
          appBar: AppBar(
            title: Text(widget.game.name),
            actions: [
              IconButton(
                icon: Icon(
                  AppState.instance.isFavorite(widget.game.id)
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () =>
                    AppState.instance.toggleFavorite(widget.game.id),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              _gameHeader(),
              const SizedBox(height: 16),
              _balanceCard(balance),
              const SizedBox(height: 20),
              _stepHeader(1, 'Masukkan Data Akun'),
              const SizedBox(height: 10),
              TextField(
                controller: _idController,
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  if (_idError != null) setState(() => _idError = null);
                },
                decoration: InputDecoration(
                  labelText: 'User ID',
                  hintText: 'Contoh: 12345678',
                  prefixIcon: const Icon(Icons.person_outline),
                  errorText: _idError,
                ),
              ),
              if (_requiresZone) ...[
                const SizedBox(height: 10),
                TextField(
                  controller: _zoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Zone ID',
                    hintText: 'Contoh: 1234',
                    prefixIcon: Icon(Icons.tag),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              _stepHeader(2, 'Pilih Nominal'),
              const SizedBox(height: 10),
              ...widget.game.denominations.map(_denomCard),
              const SizedBox(height: 20),
              _stepHeader(3, 'Voucher (Opsional)'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _voucherController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                        hintText: 'Kode voucher',
                        prefixIcon: Icon(Icons.local_offer_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _applyVoucher,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18),
                    ),
                    child: const Text('Pakai'),
                  ),
                ],
              ),
              if (_voucher != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${_voucher!.code} — ${_voucher!.description}',
                          style: const TextStyle(
                              color: Colors.green, fontSize: 12),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () => setState(() => _voucher = null),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              _summaryCard(),
            ],
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: const BoxDecoration(
              color: Color(0xFF0F1318),
              border: Border(top: BorderSide(color: Color(0xFF232A33))),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Total',
                          style: TextStyle(
                              fontSize: 11, color: Color(0xFF9AA0A6))),
                      Text(
                        _rupiah.format(_total),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF42A5F5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _processing ? null : _pay,
                      child: Text(_processing ? 'Memproses...' : 'Bayar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _stepHeader(int num, String label) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFF1565C0),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text('$num',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _gameHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF151A21), Color(0xFF1F2630)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF232A33)),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF0B0E11),
              borderRadius: BorderRadius.circular(14),
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
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.game.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(
                  '${widget.game.publisher} · ${widget.game.category}',
                  style: const TextStyle(
                      color: Color(0xFF9AA0A6), fontSize: 11),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text('${widget.game.rating}',
                        style: const TextStyle(fontSize: 11)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('TERVERIFIKASI',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 8,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _balanceCard(int balance) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF151A21),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF232A33)),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet,
              color: Color(0xFF42A5F5), size: 18),
          const SizedBox(width: 8),
          const Text('Saldo',
              style: TextStyle(fontSize: 12, color: Color(0xFF9AA0A6))),
          const Spacer(),
          Text(_rupiah.format(balance),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF42A5F5))),
        ],
      ),
    );
  }

  Widget _denomCard(Denom d) {
    final active = _denom == d;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => setState(() {
          _denom = d;
          _voucher = null;
        }),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: active
                ? const Color(0xFF1565C0).withOpacity(0.15)
                : const Color(0xFF151A21),
            border: Border.all(
              color:
                  active ? const Color(0xFF42A5F5) : const Color(0xFF232A33),
              width: active ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2630),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.diamond,
                    color: Color(0xFF42A5F5), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(d.label,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        if (d.tag != null) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: d.tag == 'HOT'
                                  ? Colors.red
                                  : d.tag == 'PROMO'
                                      ? Colors.orange
                                      : Colors.green,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(d.tag!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
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
                              color: Color(0xFF6E7681))),
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
                          color: Color(0xFF42A5F5))),
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

  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151A21),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF232A33)),
      ),
      child: Column(
        children: [
          _summaryRow('Subtotal', _rupiah.format(_subtotal)),
          if (_discount > 0)
            _summaryRow('Diskon', '- ${_rupiah.format(_discount)}',
                color: Colors.green),
          const Divider(color: Color(0xFF232A33)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Pembayaran',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              Text(_rupiah.format(_total),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF42A5F5))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {Color? color}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF9AA0A6))),
            Text(value,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
      );
}

class _ProcessingDialog extends StatefulWidget {
  const _ProcessingDialog();
  @override
  State<_ProcessingDialog> createState() => _ProcessingDialogState();
}

class _ProcessingDialogState extends State<_ProcessingDialog> {
  int _step = 0;
  static const _steps = [
    'Memverifikasi akun',
    'Memproses pembayaran',
    'Mengirim item',
    'Menyelesaikan transaksi',
  ];

  @override
  void initState() {
    super.initState();
    _advance();
  }

  void _advance() {
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      if (_step < _steps.length - 1) {
        setState(() => _step++);
        _advance();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF151A21),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                  color: Color(0xFF42A5F5), strokeWidth: 3),
            ),
            const SizedBox(height: 20),
            const Text('Memproses Transaksi',
                style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...List.generate(_steps.length, (i) {
              final done = i < _step;
              final active = i == _step;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: done
                            ? Colors.green
                            : active
                                ? const Color(0xFF42A5F5)
                                : const Color(0xFF2A3038),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: done
                          ? const Icon(Icons.check,
                              size: 12, color: Colors.white)
                          : active
                              ? const SizedBox(
                                  width: 8,
                                  height: 8,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                      color: Colors.white))
                              : null,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _steps[i],
                      style: TextStyle(
                        fontSize: 12,
                        color: done || active
                            ? Colors.white
                            : const Color(0xFF6E7681),
                        fontWeight:
                            active ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
