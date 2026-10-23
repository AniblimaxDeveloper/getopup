import 'dart:math';
import 'package:flutter/material.dart';

class ConfettiOverlay extends StatefulWidget {
  final bool show;
  const ConfettiOverlay({super.key, required this.show});
  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _particles = List.generate(40, (_) => _Particle.create(_random));
    if (widget.show) _controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(covariant ConfettiOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !oldWidget.show) {
      _particles = List.generate(40, (_) => _Particle.create(_random));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show) return const SizedBox.shrink();
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _ConfettiPainter(_particles, _controller.value),
            size: MediaQuery.of(context).size,
          );
        },
      ),
    );
  }
}

class _Particle {
  final double x;
  final double rotation;
  final double speed;
  final Color color;
  final String emoji;
  final double size;

  _Particle({
    required this.x,
    required this.rotation,
    required this.speed,
    required this.color,
    required this.emoji,
    required this.size,
  });

  static _Particle create(Random r) {
    const emojis = ['🎉', '🎊', '✨', '⭐', '💎', '🎁', '🏆', '🎯'];
    const colors = [
      Colors.amber,
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.pink,
      Colors.orange,
      Colors.teal,
    ];
    return _Particle(
      x: r.nextDouble(),
      rotation: r.nextDouble() * 2 * pi,
      speed: 0.5 + r.nextDouble(),
      color: colors[r.nextInt(colors.length)],
      emoji: emojis[r.nextInt(emojis.length)],
      size: 16 + r.nextDouble() * 16,
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  _ConfettiPainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final x = p.x * size.width;
      final y = -40 + progress * p.speed * (size.height + 80);
      final opacity = progress < 0.8 ? 1.0 : (1 - progress) * 5;
      final angle = p.rotation + progress * 6 * pi;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle);
      final tp = TextPainter(
        text: TextSpan(
          text: p.emoji,
          style: TextStyle(
            fontSize: p.size,
            color: p.color.withOpacity(opacity.clamp(0, 1)),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) => true;
}
