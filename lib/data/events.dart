import 'package:flutter/material.dart';

class AppEvent {
  final String id, title, description, tag;
  final int bonusPercent;
  final DateTime endDate;
  final IconData icon;
  final List<Color> colors;
  const AppEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.bonusPercent,
    required this.endDate,
    required this.icon,
    required this.colors,
  });

  Duration get remaining => endDate.difference(DateTime.now());
  bool get isActive => remaining.inSeconds > 0;
}

final List<AppEvent> appEvents = [
  AppEvent(
    id: 'newyear',
    title: 'Promo Awal Bulan',
    description: 'Diskon hingga 30% semua game + bonus XP 2x',
    tag: 'AKTIF',
    bonusPercent: 30,
    endDate: DateTime.now().add(const Duration(days: 7, hours: 12)),
    icon: Icons.celebration,
    colors: const [Color(0xFFC62828), Color(0xFFEF5350)],
  ),
  AppEvent(
    id: 'doublexp',
    title: 'Double XP Weekend',
    description: 'Dapatkan 2x XP untuk setiap transaksi Sabtu-Minggu',
    tag: 'WEEKEND',
    bonusPercent: 100,
    endDate: DateTime.now().add(const Duration(days: 3, hours: 6)),
    icon: Icons.bolt,
    colors: const [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
  ),
  AppEvent(
    id: 'flashsale',
    title: 'Flash Sale 24 Jam',
    description: 'Item tertentu diskon s.d. 50% — hanya 24 jam!',
    tag: 'FLASH',
    bonusPercent: 50,
    endDate: DateTime.now().add(const Duration(hours: 18, minutes: 30)),
    icon: Icons.flash_on,
    colors: const [Color(0xFFE65100), Color(0xFFFFA726)],
  ),
];
