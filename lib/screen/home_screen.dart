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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 800;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.w : 60.w, vertical: 40.h),
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
                  if (!isMobile)
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
                  if (!isMobile) const Spacer(),
                ],
              ),
            ),
            
            HeroSection(
              onViewWork: () => _scrollToSection(_projectsKey),
              onContactMe: () => _scrollToSection(_contactKey),
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.w : 150.w),
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

