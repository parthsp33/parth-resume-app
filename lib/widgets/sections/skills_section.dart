import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';

import 'package:fl_chart/fl_chart.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 800;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.w : 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technical Arsenal',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: isMobile ? 32 : 48.sp,
            ),
          ),
          SizedBox(height: 64.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Categorized Skills
              Expanded(
                flex: 3,
                child: Column(
                  children: ResumeData.skills.entries.map((entry) {
                    return _buildSkillCategory(entry.key, entry.value, context);
                  }).toList(),
                ),
              ),

              // Right: Radar Chart (Desktop Only)
              if (!isMobile)
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 60.w, top: 40.h),
                    child: SizedBox(
                      height: 450.h,
                      child: _buildRadarChart(context),
                    ),
                  ),
                ),
            ],
          ),
          if (isMobile) ...[
             SizedBox(height: 64.h),
             SizedBox(
               height: 300.h,
               child: _buildRadarChart(context),
             ),
          ],
        ],
      ),
    );
  }

  Widget _buildSkillCategory(String title, List<String> skills, BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: EdgeInsets.only(bottom: 48.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: isMobile ? 11 : 12.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 24.w,
            runSpacing: 12.h,
            children: skills.map((skill) => Text(
              skill,
              style: TextStyle(
                fontSize: isMobile ? 16 : 18.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.displayMedium?.color,
              ),
            )).toList(),
          ),
          SizedBox(height: 24.h),
          Container(
            width: double.infinity,
            height: 1,
            color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.05),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarChart(BuildContext context) {
    return RadarChart(
      RadarChartData(
        radarShape: RadarShape.polygon,
        dataSets: [
          RadarDataSet(
            fillColor: AppColors.primary.withValues(alpha: 0.2),
            borderColor: AppColors.primary,
            entryRadius: 3,
            dataEntries: ResumeData.proficiency.values.map((e) => RadarEntry(value: e * 100)).toList(),
            borderWidth: 2,
          ),
        ],
        radarBorderData: BorderSide(
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.1) ?? Colors.white10,
        ),
        tickBorderData: BorderSide(
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.1) ?? Colors.white10,
        ),
        ticksTextStyle: const TextStyle(color: Colors.transparent),
        gridBorderData: BorderSide(
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.05) ?? Colors.white10,
          width: 1,
        ),
        titlePositionPercentageOffset: 0.2,
        getTitle: (index, angle) {
          final keys = ResumeData.proficiency.keys.toList();
          return RadarChartTitle(
            text: keys[index],
            angle: angle,
          );
        },
      ),
    );
  }
}


