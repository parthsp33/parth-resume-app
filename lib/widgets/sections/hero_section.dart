import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../const/color.dart';
import '../../config/resume_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../main.dart'; // Import themeNotifier
import '../hover_scale.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewWork;
  final VoidCallback? onContactMe;
  
  const HeroSection({
    super.key,
    this.onViewWork,
    this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return Container(
          width: double.infinity,
          height: 100.h,
          constraints: BoxConstraints(minHeight: isMobile ? 600 : 800),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Stack(
            children: [
              // Theme Toggle
              Positioned(
                top: 40.h,
                right: 40.w,
                child: IconButton(
                  icon: Icon(
                    mode == ThemeMode.light ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
                    size: 24.sp,
                  ),
                  onPressed: () {
                    themeNotifier.value = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              ),
              
              // Side Social Sidebar
              if (!isMobile)
                Positioned(
                  right: 40.w,
                  top: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildEmailIcon(Icons.email_outlined, ResumeData.email, context),
                      SizedBox(height: 24.h),
                      _buildSocialIcon(Icons.link, ResumeData.linkedin, context),
                      SizedBox(height: 24.h),
                      _buildSocialIcon(Icons.code, ResumeData.github, context),
                      SizedBox(height: 24.h),
                      _buildSocialIcon(Icons.public, ResumeData.website, context),
                      SizedBox(height: 24.h),
                      _buildPhoneIcon(Icons.phone_outlined, ResumeData.mobile, context),
                      SizedBox(height: 32.h),
                      Container(
                        width: 1,
                        height: 120.h,
                        color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.1),
                      ),
                    ],
                  ),
                ),

              // Main Content
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  constraints: BoxConstraints(maxWidth: 1200.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sub-header with line
                      Row(
                        children: [
                          Container(
                            width: isMobile ? 24.w : 32.w,
                            height: 2,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: isMobile ? 8.w : 16.w),
                          Text(
                            ResumeData.role.split('|').first.trim().toUpperCase(),
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: isMobile ? 14 : 12.sp,
                              letterSpacing: isMobile ? 1.5 : 3,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 48.h),
                      // Massive Bold Title
                      Text(
                        "${ResumeData.name.split(' ').first}\n${ResumeData.name.split(' ').last}",
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: isMobile ? 56 : 120.sp,
                          color: Theme.of(context).textTheme.displayLarge?.color,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: 48.h),
                      // Introduction text
                      Container(
                        constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 500.w),
                        child: Text(
                          "Building robust, scalable, and user-centric mobile applications with Flutter and Swift.",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: isMobile ? 16 : 18.sp,
                            height: 1.6,
                          ),
                        ),
                      ),
                      SizedBox(height: 64.h),
                      // Action Buttons
                      Wrap(
                        spacing: 24.w,
                        runSpacing: 16.h,
                        children: [
                          _buildActionButton(
                            'View Work',
                            true,
                            context,
                            onPressed: onViewWork ?? () {},
                          ),
                          _buildActionButton(
                            'Contact Me',
                            false,
                            context,
                            onPressed: onContactMe ?? () {},
                          ),
                        ],
                      ),
                    ].animate(interval: 150.ms).fade(duration: 800.ms).slideY(begin: 0.1, end: 0, duration: 800.ms, curve: Curves.easeOutCubic),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(String label, bool isPrimary, BuildContext context, {required VoidCallback onPressed}) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    final bgColor = isPrimary ? Colors.white : Colors.transparent;
    final textColor = isPrimary ? Colors.black : Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = isPrimary ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.2);

    return HoverScale(
      child: InkWell(
        onTap: onPressed,
        child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 28 : 32.w, 
          vertical: isMobile ? 14 : 16.h
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
          border: isPrimary ? null : Border.all(color: borderColor ?? Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: isMobile ? 16 : 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (isPrimary) ...[
               SizedBox(width: 8.w),
               Icon(Icons.arrow_forward, color: textColor, size: isMobile ? 18 : 18.sp),
            ],
          ],
        ),
      ),
      ),
    );
  }



  Widget _buildSocialIcon(IconData icon, String url, BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Icon(
        icon,
        color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
        size: 22.sp,
      ),
    );
  }

  Widget _buildEmailIcon(IconData icon, String email, BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse('mailto:$email');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Icon(
        icon,
        color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
        size: 22.sp,
      ),
    );
  }

  Widget _buildPhoneIcon(IconData icon, String phone, BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse('tel:$phone');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Icon(
        icon,
        color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
        size: 22.sp,
      ),
    );
  }
}


