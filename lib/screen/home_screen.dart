import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/achievements_section.dart';
import '../services/visitor_service.dart';
import '../utils/responsive_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Section Keys
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initVisitorCount();
  }

  Future<void> _initVisitorCount() async {
    // Only increment once per session load
    await VisitorService().incrementVisitorCount();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
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
        color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
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
    final isMobile = context.isMobile;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: isMobile
          ? Drawer(
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
                        Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.98),
                        Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.92),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.25),
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
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.9),
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
                      _mobileNavItem('About', () => _scrollToSection(_aboutKey)),
                      _mobileNavItem('Experience', () => _scrollToSection(_experienceKey)),
                      _mobileNavItem('Achievements', () => _scrollToSection(_achievementsKey)),
                      _mobileNavItem('Projects', () => _scrollToSection(_projectsKey)),
                      _mobileNavItem('Skills', () => _scrollToSection(_skillsKey)),
                      _mobileNavItem('Contact', () => _scrollToSection(_contactKey)),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                // Avoid .w on mobile with desktop designSize (prevents tiny padding).
                horizontal: context.responsiveValue(mobile: 20.0, tablet: 40.w, desktop: 60.w),
                vertical: 40.h,
              ),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'P',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                            fontSize: isMobile ? 24 : 32.sp,
                          ),
                        ),
                        TextSpan(
                          text: 'P',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontSize: isMobile ? 24 : 32.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (isMobile)
                    IconButton(
                      onPressed: _openMobileNav,
                      icon: const Icon(Icons.menu),
                      tooltip: 'Menu',
                    )
                  else ...[
                    Row(
                      children: [
                        _navItem('ABOUT', () => _scrollToSection(_aboutKey), context),
                        SizedBox(width: 40.w),
                        _navItem('EXPERIENCE', () => _scrollToSection(_experienceKey), context),
                        SizedBox(width: 40.w),
                        _navItem('PROJECTS', () => _scrollToSection(_projectsKey), context),
                        SizedBox(width: 40.w),
                        _navItem('CONTACT', () => _scrollToSection(_contactKey), context),
                      ],
                    ),
                    const Spacer(),
                  ],
                ],
              ),
            ),
            
            HeroSection(
              onViewWork: () => _scrollToSection(_projectsKey),
              onContactMe: () => _scrollToSection(_contactKey),
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveValue(mobile: 16.0, tablet: 64.w, desktop: 150.w),
              ),
              child: Column(
                children: [
                  SizedBox(height: isMobile ? 60.h : 100.h),
                  AboutSection(key: _aboutKey),
                  SizedBox(height: isMobile ? 80.h : 150.h),
                  ExperienceSection(key: _experienceKey),
                  SizedBox(height: isMobile ? 80.h : 150.h),
                  AchievementsSection(key: _achievementsKey),
                  SizedBox(height: isMobile ? 80.h : 150.h),
                  ProjectsSection(key: _projectsKey),
                  SizedBox(height: isMobile ? 80.h : 150.h),
                  SkillsSection(key: _skillsKey),
                  SizedBox(height: isMobile ? 80.h : 150.h),
                ],
              ),
            ),
            
            ContactSection(key: _contactKey),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap, BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

