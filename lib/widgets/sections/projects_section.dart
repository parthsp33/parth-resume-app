import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/resume_data.dart';
import '../../models/project_model.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../hover_scale.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 40.w),
      child: SectionReveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            'Selected Work',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: isMobile ? 36 : 48.sp,
            ),
          ),
          SizedBox(height: isMobile ? 32.h : 64.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 32.w,
              mainAxisSpacing: 32.h,
              childAspectRatio: isMobile ? 1.0 : 1.5,
            ),
            itemCount: ResumeData.projects.length,
            itemBuilder: (context, index) {
              return _buildProjectCard(ResumeData.projects[index], context);
            },
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildProjectCard(ProjectModel project, BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
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
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile ? 8 : 10.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.white.withValues(alpha: 0.03) 
                        : AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white.withValues(alpha: 0.1) 
                          : AppColors.primary.withValues(alpha: 0.1)
                    ),
                  ),
                  child: Icon(
                    Icons.launch, 
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.primary, 
                    size: isMobile ? 18 : 20.sp
                  ),
                ),
                Text(
                   project.status.toUpperCase(),
                   style: TextStyle(
                     color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.4),
                     fontSize: isMobile ? 10 : 10.sp,
                     fontWeight: FontWeight.bold,
                     letterSpacing: 2,
                   ),
                ),
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
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: project.tools.split(',').take(3).map((tool) => _buildTechChip(tool.trim(), context)).toList(),
            ),
          ],
        ),
      ),
      ),
    );
  }


  Widget _buildTechChip(String text, BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
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
