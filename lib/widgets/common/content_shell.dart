import 'package:flutter/material.dart';

import '../../utils/responsive_utils.dart';

/// Owns horizontal page space: applies the tier gutter and caps the reading
/// width so content does not stretch across an ultra-wide monitor.
///
/// Sections must not add their own horizontal padding. Wrap them in this
/// instead, so every section lines up on the same left and right edge.
class ContentShell extends StatelessWidget {
  final Widget child;

  /// Set false for a section that wants the gutter but no width cap.
  final bool constrainWidth;

  const ContentShell({
    super.key,
    required this.child,
    this.constrainWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final padded = Padding(
      padding: EdgeInsets.symmetric(horizontal: context.gutter),
      child: child,
    );

    if (!constrainWidth) return padded;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Breakpoints.maxContentWidth,
        ),
        child: padded,
      ),
    );
  }
}
