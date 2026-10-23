import 'package:flutter/material.dart';

class PromoBanner {
  final String id, gameId, title, subtitle, tag;
  final int discountPercent;
  final List<Color> colors;
  final String gameIconUrl;
  const PromoBanner({
    required this.id,
    required this.gameId,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.discountPercent,
    required this.colors,
    required this.gameIconUrl,
  });
}
