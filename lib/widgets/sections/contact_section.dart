import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/resume_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../hover_scale.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100.h, horizontal: isMobile ? 20.w : 60.w),
      child: SectionReveal(
        child: Column(
          children: [
          // Large CTA
          Text(
            'Ready to build something together?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: isMobile ? 32 : 56.sp,
            ),
          ),
          SizedBox(height: 48.h),
          HoverScale(
            child: InkWell(
              onTap: () async {
                final Uri uri = Uri.parse('mailto:${ResumeData.email}');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get in Touch',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 18 : 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Icon(Icons.arrow_forward, color: Colors.white, size: isMobile ? 20 : 24.sp),
                ],
              ),
            ),
            ),
          ),
          SizedBox(height: 120.h),

          // Footer
          if (isMobile)
             _buildMobileFooter(context)
          else
             _buildDesktopFooter(context),

          SizedBox(height: 64.h),
          Container(
             width: double.infinity,
             height: 1,
             color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.05),
          ),
          SizedBox(height: 32.h),
          Text(
            '© 2025 ${ResumeData.name}. All rights reserved.',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.3),
              fontSize: isMobile ? 12 : 12.sp,
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(context),
        Row(
           children: [
             _buildFooterLink('EMAIL', ResumeData.email, context),
             SizedBox(width: 32.w),
             _buildFooterLink('LINKEDIN', ResumeData.linkedin, context),
             SizedBox(width: 32.w),
             _buildFooterLink('GITHUB', ResumeData.github, context),
             SizedBox(width: 32.w),
             _buildFooterLink('WEBSITE', ResumeData.website, context),
           ],
        ),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      children: [
        _buildLogo(context),
        SizedBox(height: 32.h),
        Wrap(
          spacing: 24.w,
          runSpacing: 16.h,
          alignment: WrapAlignment.center,
          children: [
            _buildFooterLink('EMAIL', ResumeData.email, context),
            _buildFooterLink('LINKEDIN', ResumeData.linkedin, context),
            _buildFooterLink('GITHUB', ResumeData.github, context),
            _buildFooterLink('WEBSITE', ResumeData.website, context),
          ],
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 700;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'P',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 24 : 28.sp,
            ),
          ),
          TextSpan(
            text: 'P',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.primary,
              fontSize: isMobile ? 24 : 28.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String label, String url, BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 700;
    return InkWell(
      onTap: () async {
        final Uri uri = url.startsWith('http') ? Uri.parse(url) : Uri.parse('mailto:$url');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
          fontSize: isMobile ? 11 : 12.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }


}

