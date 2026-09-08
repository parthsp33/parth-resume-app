import 'package:flutter/material.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/responsive_utils.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Below desktop width the 3:2 split squeezes the radar chart until its
    // axis labels overlap, so stack the chart under the skill list instead.
    final isStacked = !context.isDesktop;

    final skillList = Column(
      children: ResumeData.skills.entries.map((entry) {
        return _buildSkillCategory(entry.key, entry.value, context);
      }).toList(),
    );

    // AspectRatio keeps the radar square whatever width it is given, instead
    // of a fixed height that overflows on narrow screens.
    final radar = AspectRatio(
      aspectRatio: 1,
      child: _buildRadarChart(context),
    );

    return SectionReveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            'Technical Arsenal',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: context.headingGap),
          if (isStacked) ...[
            skillList,
            SizedBox(height: context.space(40)),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: radar,
              ),
            ),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: skillList),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 48, top: 32),
                    child: radar,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(String title, List<String> skills, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.space(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: context.fontSize(mobile: 11, desktop: 12),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 20,
            runSpacing: 12,
            children: skills.map((skill) => Text(
              skill,
              style: TextStyle(
                fontSize: context.fontSize(mobile: 15, tablet: 16, desktop: 17),
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.displayMedium?.color,
              ),
            )).toList(),
          ),
          const SizedBox(height: 20),
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


