class Voucher {
  final String code, description;
  final int? percentOff, fixedOff, minSpend, maxDiscount;
  const Voucher({
    required this.code, required this.description,
    this.percentOff, this.fixedOff, this.minSpend = 0, this.maxDiscount = 0,
  });

  int calculate(int subtotal) {
    if (subtotal < minSpend) return 0;
    int disc = 0;
    if (percentOff != null) disc = (subtotal * percentOff!) ~/ 100;
    if (fixedOff != null) disc = fixedOff!;
    if (maxDiscount > 0 && disc > maxDiscount) disc = maxDiscount;
    return disc > subtotal ? subtotal : disc;
  }
}

final List<Voucher> vouchers = [
  const Voucher(code: 'HEMAT10', description: 'Diskon 10% (maks Rp 20.000)', percentOff: 10, maxDiscount: 20000, minSpend: 20000),
  const Voucher(code: 'NEWUSER', description: 'Potongan Rp 5.000 pengguna baru', fixedOff: 5000, minSpend: 15000),
  const Voucher(code: 'GAJIAN', description: 'Diskon 15% (maks Rp 50.000)', percentOff: 15, maxDiscount: 50000, minSpend: 50000),
  const Voucher(code: 'GRATIS5K', description: 'Potongan Rp 5 khusus transaksi Rp 5', fixedOff: 5, minSpend: 5),
  const Voucher(code: 'FLASH20', description: 'Diskon 20% (maks Rp 100.000)', percentOff: 20, maxDiscount: 100000, minSpend: 100000),
  const Voucher(code: 'LAPAK50', description: 'Diskon Rp 50.000 min. Rp 250.000', fixedOff: 50000, minSpend: 250000),
];

Voucher? findVoucher(String code) {
  final c = code.trim().toUpperCase();
  for (final v in vouchers) {
    if (v.code == c) return v;
  }
  return null;
}
