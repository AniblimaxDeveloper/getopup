import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/game.dart';
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
  Denom? _denom;
  bool _loading = false;

  final _rupiah =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  Future<void> _confirm() async {
    final id = _idController.text.trim();
    if (id.length < 4) {
      _snack('User ID minimal 4 digit');
      return;
    }
    if (_denom == null) {
      _snack('Pilih nominal terlebih dahulu');
      return;
    }
    final state = AppState.instance;
    if (state.balance < _denom!.price) {
      final go = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Saldo Kurang'),
          content: Text(
              'Saldo Anda ${_rupiah.format(state.balance)}, '
              'dibutuhkan ${_rupiah.format(_denom!.price)}.'),
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

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

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
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue.shade100,
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text('Saldo: ${_rupiah.format(balance)}',
                              style: TextStyle(color: Colors.grey.shade700)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 16),
                const Text('Pilih Nominal',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...widget.game.denominations.map((d) {
                  final active = _denom == d;
                  return Card(
                    color: active ? Colors.blue.shade50 : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color:
                            active ? Colors.blueAccent : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      onTap: () => setState(() => _denom = d),
                      title: Text(d.label),
                      trailing: Text(
                        _rupiah.format(d.price),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                if (_denom != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total'),
                        Text(
                          _rupiah.format(_denom!.price),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
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
                              color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('Bayar dengan Saldo',
                          style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
