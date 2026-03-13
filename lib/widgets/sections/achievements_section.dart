import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;
    
    return Container(
      margin: EdgeInsets.only(bottom: 100.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: isMobile ? 40 : 72.w, height: 2, color: AppColors.primary),
              SizedBox(width: isMobile ? 12 : 24.w),
              Text(
                'MILESTONES', 
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: isMobile ? 12 : 14.sp,
                )
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            'Awards & Recognition',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: isMobile ? 36 : 56.sp,
            ),
          ),
          SizedBox(height: isMobile ? 40.h : 60.h),

          ...ResumeData.achievements.map((achievement) => _buildAchievementItem(
            achievement['title'],
            '', // Date is included in title for now based on input
            achievement['description'],
            context,
          )),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(String title, String date, String description, BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Padding(
      padding: EdgeInsets.only(bottom: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).textTheme.displayLarge?.color,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 18 : 20.sp,
            ),
          ),
          if (date.isNotEmpty) ...[
            SizedBox(height: 5.h),
            Text(
              date,
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: isMobile ? 12 : 13.sp),
            ),
          ],
          SizedBox(height: 12.h),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              fontSize: isMobile ? 15 : 18.sp,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

