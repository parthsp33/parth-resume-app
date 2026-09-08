import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
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
    final isMobile = context.isMobile;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12.0 : 40.w),
      child: SectionReveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            'Portfolio',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: isMobile ? 36 : 48.sp,
            ),
          ),
          SizedBox(height: isMobile ? 32.h : 64.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final int columns = w < Breakpoints.mobile
                  ? 1
                  : (w < 980 ? 2 : 3);

              final double aspectRatio = columns == 1 ? 1.05 : 1.35;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 24.w,
                  mainAxisSpacing: 24.h,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: ResumeData.projects.length,
                itemBuilder: (context, index) {
                  return _buildProjectCard(ResumeData.projects[index], context);
                },
              );
            },
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildProjectCard(ProjectModel project, BuildContext context) {
    final isMobile = context.isMobile;
    return HoverScale(
      scale: 1.02,
      child: InkWell(
        onTap: () {
          if (project.playStoreLink != null) {
          _launchURL(project.playStoreLink!);
        } else if (project.appStoreLink != null) {
          _launchURL(project.appStoreLink!);
        }
      },
      child: Container(
        padding: EdgeInsets.all(isMobile ? 16 : 24.r),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark 
              ? AppColors.surfaceDark.withValues(alpha: 0.4) 
              : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
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
                      SizedBox(width: isMobile ? 8 : 8.w),
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
                          size: isMobile ? 18 : 20.sp,
                        ),
                      ),
                  ],
                ),
                _buildStatusPill(context, project.status),
              ],
            ),
            const Spacer(),
            Text(
              project.name,
              style: TextStyle(
                fontSize: isMobile ? 22 : 24.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: isMobile ? 8.h : 12.h),
            Text(
              project.shortDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isMobile ? 15 : 14.sp,
                color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
                height: 1.5,
              ),
            ),
            const Spacer(),
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
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    ...visible.map((tool) => _buildTechChip(tool, context)),
                    if (remaining > 0)
                      _buildTechChip('+\$remaining more', context),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      ),
    );
  }


  Widget _buildIconBox(BuildContext context, Widget child) {
    final isMobile = context.isMobile;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(isMobile ? 8 : 10.r),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.r),
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
        onTap: () => _launchURL(url),
        borderRadius: BorderRadius.circular(8.r),
        child: _buildIconBox(
          context,
          FaIcon(
            icon,
            color: isDark ? Colors.white : AppColors.primary,
            size: isMobile ? 16 : 18.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusPill(BuildContext context, String status) {
    final isMobile = context.isMobile;
    final bool isLive = status.toLowerCase() == 'complete';
    final Color accent = isLive
        ? const Color(0xFF22C55E)
        : const Color(0xFFF59E0B);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 10.w,
        vertical: isMobile ? 5 : 5.h,
      ),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
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
          SizedBox(width: isMobile ? 6 : 6.w),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: accent,
              fontSize: isMobile ? 10 : 10.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(String text, BuildContext context) {
    final isMobile = context.isMobile;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white.withValues(alpha: 0.03) 
            : AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark 
              ? Colors.white.withValues(alpha: 0.05) 
              : AppColors.primary.withValues(alpha: 0.1)
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
          fontSize: isMobile ? 12 : 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }


  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
