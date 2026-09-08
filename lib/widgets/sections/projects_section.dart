import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/external_links.dart';
import '../../config/resume_data.dart';
import '../../models/project_model.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../hover_scale.dart';
import '../../utils/responsive_utils.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionReveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            'Portfolio',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: context.headingGap),
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              // Cards need roughly 300px to read well; derive columns from that
              // rather than a magic width threshold.
              final int columns = w < Breakpoints.mobile
                  ? 1
                  : (w < Breakpoints.tablet ? 2 : 3);

              const double spacing = 20;
              final double cardWidth =
                  (w - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (final project in ResumeData.projects)
                    SizedBox(
                      width: cardWidth,
                      child: _buildProjectCard(project, context),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(ProjectModel project, BuildContext context) {
    final isMobile = context.isMobile;
    final storeLink = project.playStoreLink ?? project.appStoreLink;

    return HoverScale(
      scale: 1.02,
      child: Semantics(
        button: storeLink != null,
        label: storeLink != null
            ? '${project.name}, open the app store listing'
            : project.name,
        child: InkWell(
        onTap: storeLink == null
            ? null
            : () => ExternalLinks.openOrNotify(context, Uri.parse(storeLink)),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark 
              ? AppColors.surfaceDark.withValues(alpha: 0.4) 
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.white.withValues(alpha: 0.05) 
                : Colors.grey.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: Theme.of(context).brightness == Brightness.light 
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (project.appStoreLink != null)
                      _buildStoreIcon(
                        context,
                        FontAwesomeIcons.appStoreIos,
                        project.appStoreLink!,
                        'View on App Store',
                      ),
                    if (project.appStoreLink != null && project.playStoreLink != null)
                      const SizedBox(width: 8),
                    if (project.playStoreLink != null)
                      _buildStoreIcon(
                        context,
                        FontAwesomeIcons.googlePlay,
                        project.playStoreLink!,
                        'View on Google Play',
                      ),
                    if (project.appStoreLink == null && project.playStoreLink == null)
                      _buildIconBox(
                        context,
                        Icon(
                          Icons.folder_open_rounded,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AppColors.primary,
                          size: isMobile ? 18 : 20,
                        ),
                      ),
                  ],
                ),
                _buildStatusPill(context, project.status),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              project.name,
              style: TextStyle(
                fontSize: context.fontSize(mobile: 20, tablet: 22, desktop: 23),
                fontWeight: FontWeight.w700,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              project.shortDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.fontSize(mobile: 14, desktop: 14),
                color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Builder(
              builder: (context) {
                final tools = project.tools
                    .split(',')
                    .map((t) => t.trim())
                    .where((t) => t.isNotEmpty)
                    .toList();
                final visible = tools.take(3).toList();
                final remaining = tools.length - visible.length;
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...visible.map((tool) => _buildTechChip(tool, context)),
                    if (remaining > 0)
                      _buildTechChip('+$remaining more', context),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      ),
      ),
    );
  }


  Widget _buildIconBox(BuildContext context, Widget child) {
    final isMobile = context.isMobile;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(isMobile ? 8 : 10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : AppColors.primary.withValues(alpha: 0.1),
        ),
      ),
      child: child,
    );
  }

  Widget _buildStoreIcon(
    BuildContext context,
    FaIconData icon,
    String url,
    String tooltip,
  ) {
    final isMobile = context.isMobile;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => ExternalLinks.openOrNotify(context, Uri.parse(url)),
        borderRadius: BorderRadius.circular(8),
        child: _buildIconBox(
          context,
          FaIcon(
            icon,
            color: isDark ? Colors.white : AppColors.primary,
            size: isMobile ? 16 : 18,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusPill(BuildContext context, String status) {
    final bool isLive = status.toLowerCase() == 'complete';
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Two shades per state. The light-theme greens and ambers are darkened
    // because the originals were well under 4.5:1 as 10px text on a 12% tint
    // of themselves, which was the weakest contrast in the app.
    final Color accent = isLive
        ? (isDark ? const Color(0xFF22C55E) : const Color(0xFF15803D))
        : (isDark ? const Color(0xFFF59E0B) : const Color(0xFF9A5B00));

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(String text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white.withValues(alpha: 0.03) 
            : AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark 
              ? Colors.white.withValues(alpha: 0.05) 
              : AppColors.primary.withValues(alpha: 0.1)
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          // Was alpha 0.5 at 11px, under the contrast minimum.
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.8),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
