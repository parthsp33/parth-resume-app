import 'package:flutter/material.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../../utils/responsive_utils.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    // The two-column timeline needs real desktop width. Below that the fixed
    // date gutter collides with the role text, so stack instead.
    final isStacked = !context.isDesktop;

    return SectionReveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            'Experience',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: context.headingGap),
          Stack(
            children: [
              // Vertical Timeline Line
              Positioned(
                left: isStacked ? 8 : _dateColumnWidth + 20,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 1,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.1),
                ),
              ),
              Column(
                children: ResumeData.experience.asMap().entries.map((entry) {
                  return _buildExperienceItem(
                    entry.value,
                    isStacked,
                    context,
                    isCurrent: entry.key == 0,
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Width of the date/company column in the desktop two-column layout.
  static const double _dateColumnWidth = 220;

  Widget _buildExperienceItem(
    Map<String, dynamic> exp,
    bool isStacked,
    BuildContext context, {
    bool isCurrent = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.space(56)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side (Date & Company)
          if (!isStacked)
            SizedBox(
              width: _dateColumnWidth,
              child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   Text(
                    exp['company'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.displayMedium?.color,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exp['period'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    exp['location'] ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color
                          ?.withValues(alpha: 0.45),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            ),

          // Timeline Dot
          Container(
            width: isStacked ? 16 : 40,
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isCurrent ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 10,
                            spreadRadius: 3,
                          )
                        ]
                      : null,
                ),
              ),
            ),
          ),

          // Right Side (Role & Responsibilities)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: isStacked ? 12 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isStacked) ...[
                    Text(
                      exp['company'],
                      style: TextStyle(
                        fontSize: context.fontSize(mobile: 17, desktop: 18),
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.displayMedium?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp['period'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp['location'] ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.color
                            ?.withValues(alpha: 0.45),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    exp['role'],
                    style: TextStyle(
                      fontSize: context.fontSize(mobile: 18, desktop: 20),
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.displayMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ... (exp['responsibilities'] as List).map((res) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Padding(
                           padding: const EdgeInsets.only(top: 8),
                           child: Container(
                             width: 4,
                             height: 4,
                             decoration: BoxDecoration(
                               color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.3),
                               shape: BoxShape.circle,
                             ),
                           ),
                         ),
                         const SizedBox(width: 16),
                         Expanded(
                           child: Text(
                             res,
                             style: Theme.of(context).textTheme.bodyMedium,
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
