import 'package:flutter/material.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../../utils/responsive_utils.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

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
                'BACKGROUND',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Education',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: context.headingGap),
          ...ResumeData.education.map((edu) => _buildEducationItem(edu, context)),
        ],
      ),
    );
  }

  Widget _buildEducationItem(Map<String, dynamic> edu, BuildContext context) {
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Padding(
      padding: EdgeInsets.only(bottom: context.space(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${edu['degree']}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).textTheme.displayLarge?.color,
                  fontWeight: FontWeight.w700,
                  fontSize: context.fontSize(mobile: 18, tablet: 20, desktop: 22),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '${edu['institution']}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '${edu['period']}  |  ${edu['location']}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: bodyColor?.withValues(alpha: 0.7),
                  letterSpacing: 1,
                ),
          ),
          SizedBox(height: context.space(20)),
          _buildGradeBadge('${edu['grade']}', context),
        ],
      ),
    );
  }

  Widget _buildGradeBadge(String grade, BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    // The brand red is under the contrast minimum as text on white, so the
    // light theme uses the darkened variant.
    final labelColor = isLight ? AppColors.primaryOnLight : AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Text(
        grade,
        style: TextStyle(
          color: labelColor,
          fontSize: context.fontSize(mobile: 13, tablet: 14, desktop: 14),
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
