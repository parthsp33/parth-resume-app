import 'dart:ui';

import 'package:flutter/material.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/achievements_section.dart';
import '../widgets/sections/education_section.dart';
import '../services/visitor_service.dart';
import '../utils/responsive_utils.dart';
import '../widgets/common/content_shell.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// One nav entry. The desktop row and the mobile drawer both render this same
/// list, so the two menus can never drift apart.
class _NavSection {
  final String label;
  final GlobalKey key;

  const _NavSection(this.label, this.key);
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Section Keys
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late final List<_NavSection> _navSections = [
    _NavSection('About', _aboutKey),
    _NavSection('Experience', _experienceKey),
    _NavSection('Education', _educationKey),
    _NavSection('Achievements', _achievementsKey),
    _NavSection('Projects', _projectsKey),
    _NavSection('Skills', _skillsKey),
    _NavSection('Contact', _contactKey),
  ];

  static const double _navHeight = 72;

  /// Drives the nav background: transparent at the top, solid once scrolled.
  bool _navScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _initVisitorCount();
  }

  Future<void> _initVisitorCount() async {
    // Only increment once per session load
    await VisitorService().incrementVisitorCount();
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 24;
    if (scrolled != _navScrolled) {
      setState(() => _navScrolled = scrolled);
    }
  }

  /// Scrolls a section to just below the sticky nav, so the heading is not
  /// hidden underneath it.
  void _scrollToSection(GlobalKey key) {
    final sectionContext = key.currentContext;
    if (sectionContext == null || !_scrollController.hasClients) return;

    final box = sectionContext.findRenderObject() as RenderBox?;
    if (box == null) return;

    final dyInViewport = box.localToGlobal(Offset.zero).dy;
    final target = (_scrollController.offset + dyInViewport - _navHeight - 16)
        .clamp(0.0, _scrollController.position.maxScrollExtent);

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _openMobileNav() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Widget _mobileNavItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color:
            Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
      ),
      iconColor: Theme.of(context).colorScheme.primary,
      onTap: () {
        Navigator.of(context).maybePop(); // close drawer
        onTap();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Below this width six nav labels no longer fit next to the logo.
    final useDrawer = context.useCompactNav;
    final sectionGap = context.sectionGap;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: useDrawer ? _buildDrawer(context) : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  topPadding: _navHeight,
                  onViewWork: () => _scrollToSection(_projectsKey),
                  onContactMe: () => _scrollToSection(_contactKey),
                ),

                // One padding owner for every middle section. The sections
                // themselves no longer set horizontal padding.
                ContentShell(
                  child: Column(
                    children: [
                      // The hero already leaves slack under its buttons
                      // because it centres inside a minimum height, so a full
                      // sectionGap here reads as a large empty band.
                      SizedBox(height: context.space(32)),
                      AboutSection(key: _aboutKey),
                      SizedBox(height: sectionGap),
                      ExperienceSection(key: _experienceKey),
                      SizedBox(height: sectionGap),
                      EducationSection(key: _educationKey),
                      SizedBox(height: sectionGap),
                      AchievementsSection(key: _achievementsKey),
                      SizedBox(height: sectionGap),
                      ProjectsSection(key: _projectsKey),
                      SizedBox(height: sectionGap),
                      SkillsSection(key: _skillsKey),
                      SizedBox(height: sectionGap),
                    ],
                  ),
                ),

                ContactSection(key: _contactKey),
              ],
            ),
          ),

          // Sticky nav
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildNavBar(context, useDrawer),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar(BuildContext context, bool useDrawer) {
    final bg = Theme.of(context).scaffoldBackgroundColor;
    final divider =
        Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.08) ??
            Colors.transparent;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _navScrolled ? 12 : 0,
          sigmaY: _navScrolled ? 12 : 0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: _navHeight,
          decoration: BoxDecoration(
            color:
                _navScrolled ? bg.withValues(alpha: 0.85) : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: _navScrolled ? divider : Colors.transparent,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.gutter),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'P',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      TextSpan(
                        text: 'P',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                if (useDrawer)
                  IconButton(
                    onPressed: _openMobileNav,
                    icon: const Icon(Icons.menu),
                    tooltip: 'Menu',
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final section in _navSections)
                        Padding(
                          padding: EdgeInsets.only(left: context.space(28)),
                          child: _navItem(
                            section.label.toUpperCase(),
                            () => _scrollToSection(section.key),
                            context,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context)
                    .scaffoldBackgroundColor
                    .withValues(alpha: 0.98),
                Theme.of(context)
                    .scaffoldBackgroundColor
                    .withValues(alpha: 0.92),
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.25),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.9),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Menu',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Theme.of(context).dividerColor.withValues(alpha: 0.25),
              ),
              for (final section in _navSections)
                _mobileNavItem(
                  section.label,
                  () => _scrollToSection(section.key),
                ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap, BuildContext context) {
    return Semantics(
      button: true,
      label: 'Go to $title section',
      child: InkWell(
        onTap: onTap,
        child: Padding(
          // Was a bare Text, so the tap target was only as tall as the glyphs.
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: context.fontSize(mobile: 12, tablet: 12, desktop: 13),
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
