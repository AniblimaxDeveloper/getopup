import 'package:flutter/material.dart';

class ThemeColorOption {
  final String name;
  final Color primary;
  final Color light;
  final Color dark;
  final Color accent;
  const ThemeColorOption({
    required this.name,
    required this.primary,
    required this.light,
    required this.dark,
    required this.accent,
  });
}

final List<ThemeColorOption> themeColorOptions = [
  const ThemeColorOption(
    name: 'Biru',
    primary: Color(0xFF1565C0),
    light: Color(0xFFE3F2FD),
    dark: Color(0xFF0D47A1),
    accent: Color(0xFF42A5F5),
  ),
  const ThemeColorOption(
    name: 'Ungu',
    primary: Color(0xFF6A1B9A),
    light: Color(0xFFF3E5F5),
    dark: Color(0xFF4A148C),
    accent: Color(0xFFAB47BC),
  ),
  const ThemeColorOption(
    name: 'Hijau',
    primary: Color(0xFF2E7D32),
    light: Color(0xFFE8F5E9),
    dark: Color(0xFF1B5E20),
    accent: Color(0xFF66BB6A),
  ),
  const ThemeColorOption(
    name: 'Oranye',
    primary: Color(0xFFEF6C00),
    light: Color(0xFFFFF3E0),
    dark: Color(0xFFE65100),
    accent: Color(0xFFFFA726),
  ),
  const ThemeColorOption(
    name: 'Merah',
    primary: Color(0xFFC62828),
    light: Color(0xFFFFEBEE),
    dark: Color(0xFFB71C1C),
    accent: Color(0xFFEF5350),
  ),
  const ThemeColorOption(
    name: 'Pink',
    primary: Color(0xFFAD1457),
    light: Color(0xFFFCE4EC),
    dark: Color(0xFF880E4F),
    accent: Color(0xFFEC407A),
  ),
  const ThemeColorOption(
    name: 'Teal',
    primary: Color(0xFF00695C),
    light: Color(0xFFE0F2F1),
    dark: Color(0xFF004D40),
    accent: Color(0xFF26A69A),
  ),
  const ThemeColorOption(
    name: 'Indigo',
    primary: Color(0xFF283593),
    light: Color(0xFFE8EAF6),
    dark: Color(0xFF1A237E),
    accent: Color(0xFF5C6BC0),
  ),
];
