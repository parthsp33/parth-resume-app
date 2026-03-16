import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SectionReveal extends StatefulWidget {
  final Widget child;
  final double threshold;
  final Duration delay;
  
  const SectionReveal({
    super.key,
    required this.child,
    this.threshold = 0.1,
    this.delay = Duration.zero,
  });

  @override
  State<SectionReveal> createState() => _SectionRevealState();
}

class _SectionRevealState extends State<SectionReveal> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: (info) {
        if (!_isVisible && info.visibleFraction >= widget.threshold) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: widget.child.animate(
        target: _isVisible ? 1 : 0,
        delay: widget.delay,
      ).fade(duration: 800.ms).slideY(
        begin: 0.05,
        end: 0,
        duration: 800.ms,
        curve: Curves.easeOutCubic,
      ),
    );
  }
}
