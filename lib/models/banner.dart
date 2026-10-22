import 'package:flutter/material.dart';

class PromoBanner {
  final String id, title, subtitle, tag;
  final List<Color> colors;
  const PromoBanner({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.colors,
  });
}
