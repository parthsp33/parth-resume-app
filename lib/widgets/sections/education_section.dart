import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../../utils/responsive_utils.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    int index = ResumeData.experience.length + 1;

    return SectionReveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ...ResumeData.education.asMap().entries.map((entry) {
          int currentIndex = index + entry.key;
          return _buildEducationItem(entry.value, currentIndex, context);
        }),
      ],
      ),
    );
  }

  Widget _buildEducationItem(Map<String, dynamic> edu, int index, BuildContext context) {
    final isMobile = context.isMobile;
    String indexStr = index.toString().padLeft(2, '0');

    return Container(
      margin: EdgeInsets.only(bottom: 150.h),
      child: Stack(
        children: [
          Positioned(
            top: -40.h,
            left: -20.w,
            child: Opacity(
              opacity: 0.1,
              child: Text(
                indexStr,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 120.sp : 240.sp,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).textTheme.displayLarge?.color?.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(top: 60.h, left: isMobile ? 0 : 80.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 72.w,
                      height: 2,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 24.w),
                    Text(
                      'STATION $indexStr',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  '${edu['degree']} at\n${edu['institution']}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(height: 16.h),
                Text(
                  '${edu['period']} | ${edu['location']}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 32.h),
                _buildGradeBadge(edu['grade'], context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeBadge(String grade, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Text(
        grade,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

