import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/game.dart';
import '../models/transaction.dart';
import '../services/storage_service.dart';

class TopupScreen extends StatefulWidget {
  final Game game;
  TopupScreen({required this.game});

  @override
  _TopupScreenState createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  final _idController = TextEditingController();
  final _zoneController = TextEditingController();
  String? _selectedDenom;
  bool _isLoading = false;

  final _rupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  Future<void> _processTopup() async {
    final id = _idController.text.trim();
    if (id.isEmpty || _selectedDenom == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Isi User ID dan pilih nominal')),
      );
      return;
    }
    if (id.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID minimal 4 digit')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2));

    final tx = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      gameName: widget.game.name,
      userId: id,
      zoneId: _zoneController.text.trim(),
      item: _selectedDenom!,
      amount: 5,
      createdAt: DateTime.now(),
      status: 'success',
    );
    await StorageService.saveTransaction(tx);

    if (!mounted) return;
    setState(() => _isLoading = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Berhasil'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Game: ${widget.game.name}'),
            Text('User ID: $id'),
            if (_zoneController.text.isNotEmpty)
              Text('Zone: ${_zoneController.text}'),
            Text('Item: $_selectedDenom'),
            Divider(),
            Text(
              'Total: ${_rupiah.format(5)}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Selesai'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.game.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _zoneController,
              decoration: InputDecoration(
                labelText: 'Zone ID (opsional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.tag),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedDenom,
              items: widget.game.denominations
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedDenom = v),
              decoration: InputDecoration(
                labelText: 'Pilih Nominal',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.card_giftcard),
              ),
            ),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Bayar', style: TextStyle(fontSize: 16)),
                  Text(
                    _rupiah.format(5),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _processTopup,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
              ),
              child: _isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Konfirmasi Top Up',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
