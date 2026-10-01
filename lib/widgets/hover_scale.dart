import 'package:flutter/material.dart';

class HoverScale extends StatefulWidget {
  final Widget child;
  final double scale;
  final Curve curve;
  final Duration duration;
  final Offset hoverOffset;

  const HoverScale({
    super.key,
    required this.child,
    this.scale = 1.03,
    this.curve = Curves.easeOutCubic,
    this.duration = const Duration(milliseconds: 180),
    this.hoverOffset = const Offset(0, -2),
  });

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: widget.curve,
        transform: Matrix4.translationValues(
          _isHovered ? widget.hoverOffset.dx : 0,
          _isHovered ? widget.hoverOffset.dy : 0,
          0,
        ),
        child: AnimatedScale(
          scale: _isHovered ? widget.scale : 1.0,
          duration: widget.duration,
          curve: widget.curve,
          child: widget.child,
        ),
      ),
    );
  }
}
