import 'package:flutter/material.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../../utils/responsive_utils.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return SectionReveal(
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
                  fontSize: context.fontSize(mobile: 13, desktop: 15),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Container(
                width: 40,
                height: 1,
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'About Me',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: context.headingGap),

          // Main Content Grid
          if (isMobile)
            Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 _buildBio(context),
                 SizedBox(height: context.space(56)),
                 _buildStats(context),
                 SizedBox(height: context.space(56)),
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
                      SizedBox(height: context.space(72)),
                      _buildStats(context),
                    ],
                  ),
                ),
                SizedBox(width: context.space(80)),
                // Right Column: Education & Interests
                Expanded(
                  flex: 2,
                  child: _buildEducationAndInterests(context),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    final isMobile = context.isMobile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ResumeData.experienceSummary,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.8,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: context.space(28)),
        ...ResumeData.summaryPoints.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: isMobile ? 12 : 16),
                Expanded(
                  child: Text(
                    point,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.7,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color
                          ?.withValues(alpha: 0.75),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    return Wrap(
      spacing: 48,
      runSpacing: 28,
      children: [
        _buildStatItem(ResumeData.totalExperience, 'YEARS EXPERIENCE', context),
        _buildStatItem(ResumeData.totalProjects, 'PROJECTS COMPLETED', context),
      ],
    );
  }

  Widget _buildStatItem(String val, String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          val,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: context.fontSize(mobile: 36, tablet: 42, desktop: 48),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: context.fontSize(mobile: 11, desktop: 12),
            color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildEducationAndInterests(BuildContext context) {
    // Heading colour comes from the theme. It used to be hardcoded white,
    // which made these headings invisible in the light theme.
    final headingColor = Theme.of(context).textTheme.displayMedium?.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBlockHeading('Education', context),
        ...ResumeData.education.map((edu) => Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                edu['degree'],
                style: TextStyle(
                  fontSize: context.fontSize(mobile: 15, desktop: 16),
                  fontWeight: FontWeight.w700,
                  color: headingColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${edu['institution']} (${edu['location']})',
                style: TextStyle(
                  fontSize: context.fontSize(mobile: 13, desktop: 14),
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                edu['period'],
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        )),

        SizedBox(height: context.space(40)),
        _buildBlockHeading('Interests', context),
        Wrap(
          spacing: 12,
          runSpacing: 12,
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

  Widget _buildBlockHeading(String title, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: context.fontSize(mobile: 18, desktop: 20),
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.displayMedium?.color,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 1,
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.1),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildInterestChip(String label, BuildContext context) {
    final onSurface =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: onSurface.withValues(alpha: 0.12)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
