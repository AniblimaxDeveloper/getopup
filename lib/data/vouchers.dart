class Voucher {
  final String code;
  final String description;
  final int? percentOff; // persen diskon (0-100)
  final int? fixedOff;   // potongan rupiah
  final int minSpend;
  final int maxDiscount; // 0 = tanpa batas
  const Voucher({
    required this.code,
    required this.description,
    this.percentOff,
    this.fixedOff,
    this.minSpend = 0,
    this.maxDiscount = 0,
  });

  int calculate(int subtotal) {
    if (subtotal < minSpend) return 0;
    int disc = 0;
    if (percentOff != null) disc = (subtotal * percentOff!) ~/ 100;
    if (fixedOff != null) disc = fixedOff!;
    if (maxDiscount > 0 && disc > maxDiscount) disc = maxDiscount;
    if (disc > subtotal) disc = subtotal;
    return disc;
  }
}

final List<Voucher> vouchers = [
  Voucher(
    code: 'HEMAT10',
    description: 'Diskon 10% (maks Rp 20.000)',
    percentOff: 10,
    maxDiscount: 20000,
    minSpend: 20000,
  ),
  Voucher(
    code: 'NEWUSER',
    description: 'Potongan Rp 5.000 untuk pengguna baru',
    fixedOff: 5000,
    minSpend: 15000,
  ),
  Voucher(
    code: 'GAJIAN',
    description: 'Diskon 15% (maks Rp 50.000)',
    percentOff: 15,
    maxDiscount: 50000,
    minSpend: 50000,
  ),
  Voucher(
    code: 'GRATIS5K',
    description: 'Potongan Rp 5 khusus transaksi Rp 5',
    fixedOff: 5,
    minSpend: 5,
  ),
  Voucher(
    code: 'FLASH20',
    description: 'Diskon 20% (maks Rp 100.000)',
    percentOff: 20,
    maxDiscount: 100000,
    minSpend: 100000,
  ),
];

Voucher? findVoucher(String code) {
  final c = code.trim().toUpperCase();
  for (final v in vouchers) {
    if (v.code == c) return v;
  }
  return null;
}
