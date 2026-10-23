import 'package:flutter/material.dart';

class MarqueeBanner extends StatefulWidget {
  final List<String> messages;
  final Color backgroundColor;
  final Color textColor;
  const MarqueeBanner({
    super.key,
    required this.messages,
    this.backgroundColor = const Color(0xFFFFF3E0),
    this.textColor = const Color(0xFFE65100),
  });
  @override
  State<MarqueeBanner> createState() => _MarqueeBannerState();
}

class _MarqueeBannerState extends State<MarqueeBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.messages.join('   •   ');
    return Container(
      height: 32,
      decoration: BoxDecoration(color: widget.backgroundColor),
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final textWidth = text.length * 7.5;
                final totalWidth = textWidth + constraints.maxWidth;
                final x = constraints.maxWidth - _controller.value * totalWidth;
                return Stack(
                  children: [
                    Positioned(
                      left: x,
                      top: 0,
                      bottom: 0,
                      child: Row(
                        children: [
                          const Icon(Icons.campaign,
                              color: Color(0xFFE65100), size: 18),
                          const SizedBox(width: 8),
                          Text(
                            text,
                            style: TextStyle(
                              color: widget.textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
