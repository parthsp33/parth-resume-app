import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:my_resume_app/main.dart';
import 'package:my_resume_app/utils/responsive_utils.dart';

/// Pumps the whole app at a fixed logical size.
///
/// The old test never set a size, so everything ran at the default 800x600 and
/// the desktop layout was never built by any test.
Future<void> _pumpAppAt(WidgetTester tester, Size logicalSize) async {
  // Avoid pending timers from visibility_detector in widget tests.
  VisibilityDetectorController.instance.updateInterval = Duration.zero;

  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = logicalSize;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const MyApp());
  // Let initial flutter_animate timers elapse.
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  testWidgets('App builds at mobile width', (WidgetTester tester) async {
    await _pumpAppAt(tester, const Size(390, 844));

    // Section headings are present.
    expect(find.text('Portfolio'), findsWidgets);
    expect(find.text('Education'), findsWidgets);

    // Below compactNav the horizontal row is gone and the drawer button is
    // shown instead. The drawer itself uses title-case labels, the desktop row
    // uses upper case, so the absence of upper case proves the row is gone.
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.text('EDUCATION'), findsNothing);
  });

  testWidgets('App builds at desktop width and shows the nav row',
      (WidgetTester tester) async {
    await _pumpAppAt(tester, const Size(1440, 900));

    // The desktop nav row upper-cases its labels.
    expect(find.text('EXPERIENCE'), findsOneWidget);
    expect(find.text('EDUCATION'), findsOneWidget);

    // The section heading itself is separate, and title case.
    expect(find.text('Education'), findsWidgets);

    // The drawer button only exists in the compact layout.
    expect(find.byIcon(Icons.menu), findsNothing);
  });

  testWidgets('Nav row collapses to a drawer button just below compactNav',
      (WidgetTester tester) async {
    await _pumpAppAt(tester, const Size(Breakpoints.compactNav - 1, 900));
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });

  testWidgets('Nav row is shown at compactNav', (WidgetTester tester) async {
    await _pumpAppAt(tester, const Size(Breakpoints.compactNav, 900));
    expect(find.byIcon(Icons.menu), findsNothing);
    expect(find.text('EDUCATION'), findsOneWidget);
  });
}
