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

  /// Created once per State, never per build.
  ///
  /// VisibilityDetector keys its global registry by this value. Building a
  /// fresh UniqueKey inside build() registered a new entry and disposed the
  /// old one on every rebuild, for every section, on every scroll.
  late final Key _detectorKey = widget.key ?? UniqueKey();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
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
      )
          .fade(duration: 700.ms, curve: Curves.easeOutCubic)
          .slideY(
            begin: 0.08,
            end: 0,
            duration: 700.ms,
            curve: Curves.easeOutCubic,
          )
          .scaleXY(
            begin: 0.985,
            end: 1,
            duration: 700.ms,
            curve: Curves.easeOutCubic,
          ),
    );
  }
}
