import 'package:flutter/material.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../../utils/responsive_utils.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    
    return SectionReveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              Container(
                width: isMobile ? 40 : 72,
                height: 2,
                color: AppColors.primary,
              ),
              SizedBox(width: isMobile ? 12 : 24),
              Text(
                'MILESTONES',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Awards & Recognition',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: context.headingGap),

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
    return Padding(
      padding: EdgeInsets.only(bottom: context.space(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).textTheme.displayLarge?.color,
              fontWeight: FontWeight.w700,
              fontSize: context.fontSize(mobile: 17, tablet: 19, desktop: 20),
            ),
          ),
          if (date.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              date,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: context.fontSize(mobile: 12, desktop: 13),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

