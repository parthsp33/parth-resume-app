import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';
import '../section_reveal.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.w : 40.w),
      child: SectionReveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            'Experience',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: isMobile ? 32 : 48.sp,
            ),
          ),
          SizedBox(height: 64.h),
          Stack(
            children: [
              // Vertical Timeline Line
              Positioned(
                left: isMobile ? 7.w : 250.w,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 1,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.1),
                ),
              ),
              Column(
                children: ResumeData.experience.asMap().entries.map((entry) {
                  return _buildExperienceItem(entry.value, isMobile, context);
                }).toList(),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildExperienceItem(Map<String, dynamic> exp, bool isMobile, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 64.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side (Date & Company)
          if (!isMobile)
            Container(
              width: 230.w,
              padding: EdgeInsets.only(right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   Text(
                    exp['company'],
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.displayMedium?.color,
                    ),
                    textAlign: isMobile ? TextAlign.left : TextAlign.right,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    exp['period'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),

          // Timeline Dot
          Container(
            width: isMobile ? 15.w : 40.w,
            padding: EdgeInsets.only(top: 8.h),
            child: Center(
              child: Container(
                width: 10.r,
                height: 10.r,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // Right Side (Role & Responsibilities)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: isMobile ? 12.w : 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isMobile) ...[
                    Text(
                      exp['company'],
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.displayMedium?.color,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      exp['period'],
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                  Text(
                    exp['role'],
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.displayMedium?.color,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ... (exp['responsibilities'] as List).map((res) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Padding(
                           padding: EdgeInsets.only(top: 8.h),
                           child: Container(
                             width: 4.w,
                             height: 4.h,
                             decoration: BoxDecoration(
                               color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.3),
                               shape: BoxShape.circle,
                             ),
                           ),
                         ),
                         SizedBox(width: 16.w),
                         Expanded(
                           child: Text(
                             res,
                             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                               fontSize: isMobile ? 14 : 16.sp,
                             ),
                           ),
                         ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
