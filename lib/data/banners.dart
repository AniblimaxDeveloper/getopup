import 'package:flutter/material.dart';
import '../models/banner.dart';

final List<PromoBanner> promoBanners = [
  const PromoBanner(
    id: 'welcome',
    title: 'SELAMAT DATANG',
    subtitle: 'Diskon 20% transaksi pertama\nKode: NEWUSER',
    tag: 'getopup.com',
    colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
  ),
  const PromoBanner(
    id: 'flash',
    title: 'FLASH SALE',
    subtitle: 'Diskon hingga Rp 100.000\nKode: FLASH20',
    tag: 'HARI INI',
    colors: [Color(0xFFE53935), Color(0xFFFF7043)],
  ),
  const PromoBanner(
    id: 'gajian',
    title: 'PROMO GAJIAN',
    subtitle: 'Diskon 15% semua game\nKode: GAJIAN',
    tag: 'Terbatas',
    colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
  ),
  const PromoBanner(
    id: 'hemat',
    title: 'HEMAT 10%',
    subtitle: 'Pakai kode HEMAT10\nMaks Rp 20.000',
    tag: 'getopup.com',
    colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
  ),
  const PromoBanner(
    id: 'gratis5k',
    title: 'GRATIS Rp 5',
    subtitle: 'Khusus transaksi pertama\nKode: GRATIS5K',
    tag: 'NEW',
    colors: [Color(0xFFEF6C00), Color(0xFFFFA726)],
  ),
];
