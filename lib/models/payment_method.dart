import 'package:flutter/material.dart';

class PaymentMethod {
  final String id, name, group;
  final IconData icon;
  final Color color;
  final int fee;
  const PaymentMethod({
    required this.id,
    required this.name,
    required this.group,
    required this.icon,
    required this.color,
    this.fee = 0,
  });
}

final List<PaymentMethod> paymentMethods = [
  const PaymentMethod(id: 'lapakcoins', name: 'Lapakgaming Coins', group: 'Saldo', icon: Icons.monetization_on, color: Color(0xFFFFC107)),
  const PaymentMethod(id: 'gopay', name: 'GoPay', group: 'E-Wallet & QRIS', icon: Icons.account_balance_wallet, color: Color(0xFF00AA13)),
  const PaymentMethod(id: 'dana', name: 'DANA', group: 'E-Wallet & QRIS', icon: Icons.account_balance_wallet, color: Color(0xFF118EEA)),
  const PaymentMethod(id: 'ovo', name: 'OVO', group: 'E-Wallet & QRIS', icon: Icons.account_balance_wallet, color: Color(0xFF4C3494)),
  const PaymentMethod(id: 'qris', name: 'QRIS', group: 'E-Wallet & QRIS', icon: Icons.qr_code, color: Color(0xFFE53935), fee: 0),
  const PaymentMethod(id: 'linkaja', name: 'LINKAJA', group: 'E-Wallet & QRIS', icon: Icons.account_balance_wallet, color: Color(0xFFE82529)),
  const PaymentMethod(id: 'shopeepay', name: 'ShopeePay', group: 'E-Wallet & QRIS', icon: Icons.account_balance_wallet, color: Color(0xFFEE4D2D)),
  const PaymentMethod(id: 'astrapay', name: 'AstraPay', group: 'E-Wallet & QRIS', icon: Icons.account_balance_wallet, color: Color(0xFF0066B3)),
  const PaymentMethod(id: 'va_bca', name: 'VA BCA', group: 'Virtual Account', icon: Icons.account_balance, color: Color(0xFF003D79), fee: 1500),
  const PaymentMethod(id: 'va_mandiri', name: 'VA Mandiri', group: 'Virtual Account', icon: Icons.account_balance, color: Color(0xFF003D79), fee: 1700),
  const PaymentMethod(id: 'va_bri', name: 'VA BRI', group: 'Virtual Account', icon: Icons.account_balance, color: Color(0xFF003D79), fee: 2000),
  const PaymentMethod(id: 'va_bni', name: 'VA BNI', group: 'Virtual Account', icon: Icons.account_balance, color: Color(0xFF003D79), fee: 1700),
  const PaymentMethod(id: 'va_permata', name: 'VA Permata', group: 'Virtual Account', icon: Icons.account_balance, color: Color(0xFF003D79), fee: 1700),
  const PaymentMethod(id: 'va_cimb', name: 'VA CIMB', group: 'Virtual Account', icon: Icons.account_balance, color: Color(0xFF003D79), fee: 2000),
  const PaymentMethod(id: 'va_danamon', name: 'VA Danamon', group: 'Virtual Account', icon: Icons.account_balance, color: Color(0xFF003D79), fee: 3000),
  const PaymentMethod(id: 'alfamart', name: 'Alfamart', group: 'Gerai', icon: Icons.store, color: Color(0xFFE53935), fee: 2500),
  const PaymentMethod(id: 'indomaret', name: 'Indomaret', group: 'Gerai', icon: Icons.store, color: Color(0xFFE53935), fee: 2500),
  const PaymentMethod(id: 'atm_bersama', name: 'ATM Bersama', group: 'ATM', icon: Icons.atm, color: Color(0xFF546E7A), fee: 2000),
  const PaymentMethod(id: 'credit_card', name: 'Kartu Kredit', group: 'Kartu', icon: Icons.credit_card, color: Color(0xFF1976D2), fee: 2500),
];
