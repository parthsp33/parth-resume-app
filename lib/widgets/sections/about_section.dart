import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../../utils/responsive_utils.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.w : 40.w),
      child: SectionReveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Section Prefix (01 — )
          Row(
            children: [
              Text(
                '01 — ',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isMobile ? 14 : 16.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Container(
                width: 40.w,
                height: 1,
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'About Me',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: isMobile ? 32 : 48.sp,
            ),
          ),
          SizedBox(height: 64.h),

          // Main Content Grid
          if (isMobile)
            Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 _buildBio(context),
                 SizedBox(height: 64.h),
                 _buildStats(context),
                 SizedBox(height: 64.h),
                 _buildEducationAndInterests(context),
               ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Bio & Stats
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBio(context),
                      SizedBox(height: 80.h),
                      _buildStats(context),
                    ],
                  ),
                ),
                SizedBox(width: 100.w),
                // Right Column: Education & Interests
                Expanded(
                  flex: 2,
                  child: _buildEducationAndInterests(context),
                ),
              ],
            ),
        ],
      ),
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    final isMobile = context.isMobile;
    return Text(
      ResumeData.experienceSummary,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        height: 1.8,
        fontSize: isMobile ? 16 : 18.sp,
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    return Wrap(
      spacing: 60.w,
      runSpacing: 32.h,
      children: [
        _buildStatItem(ResumeData.totalExperience, 'YEARS EXPERIENCE', context),
        _buildStatItem(ResumeData.totalProjects, 'PROJECTS COMPLETED', context),
      ],
    );
  }

  Widget _buildStatItem(String val, String label, BuildContext context) {
    final isMobile = context.isMobile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          val,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 40 : 48.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 11 : 12.sp,
            color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildEducationAndInterests(BuildContext context) {
    final isMobile = context.isMobile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Education
        Text(
          'Education',
          style: TextStyle(
            fontSize: isMobile ? 18 : 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          height: 1,
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.1),
        ),
        SizedBox(height: 32.h),
        ...ResumeData.education.map((edu) => Padding(
          padding: EdgeInsets.only(bottom: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                edu['degree'],
                style: TextStyle(
                  fontSize: isMobile ? 15 : 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${edu['institution']} (${edu['location']})',
                style: TextStyle(
                  fontSize: isMobile ? 13 : 14.sp,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                edu['period'],
                style: TextStyle(
                  fontSize: isMobile ? 12 : 12.sp,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        )),

        SizedBox(height: 48.h),
        // Interests
        Text(
          'Interests',
          style: TextStyle(
            fontSize: isMobile ? 18 : 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          height: 1,
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.1),
        ),
        SizedBox(height: 32.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            _buildInterestChip('Traveling', context),
            _buildInterestChip('Gaming', context),
            _buildInterestChip('Reading', context),
            _buildInterestChip('Open Source', context),
          ],
        ),
      ],
    );
  }

  Widget _buildInterestChip(String label, BuildContext context) {
    final isMobile = context.isMobile;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isMobile ? 13 : 13.sp,
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
