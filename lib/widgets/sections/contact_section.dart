import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/resume_data.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../hover_scale.dart';
import '../visitor_counter.dart';
import '../../utils/responsive_utils.dart';
import '../common/content_shell.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionGap),
      child: ContentShell(
        child: SectionReveal(
        child: Column(
          children: [
          // Large CTA
          Text(
            'Ready to build something together?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: context.space(44)),
          HoverScale(
            child: InkWell(
              onTap: () async {
                final Uri uri = Uri.parse(
                  "https://mail.google.com/mail/?view=cm&fs=1&to=${ResumeData.email}&su=Contact from Website&body=Hello",
                );
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 32 : 44, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get in Touch',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: context.fontSize(mobile: 17, desktop: 19),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 22),
                ],
              ),
            ),
            ),
          ),
          SizedBox(height: context.space(100)),

          // Footer
          if (isMobile)
             _buildMobileFooter(context)
          else
             _buildDesktopFooter(context),

          SizedBox(height: context.space(56)),
          Container(
             width: double.infinity,
             height: 1,
             color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.05),
          ),
          const SizedBox(height: 28),
          if (isMobile)
            Column(
              children: [
                const VisitorCounter(),
                const SizedBox(height: 12),
                Text(
                  '© 2025 ${ResumeData.name}. All rights reserved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.3),
                    fontSize: 12,
                  ),
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '© 2025 ${ResumeData.name}. All rights reserved.',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.3),
                    fontSize: 12,
                  ),
                ),
                const VisitorCounter(),
              ],
            ),
        ],
      ),
      ),
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(context),
        Row(
           children: [
             _buildFooterLink('EMAIL', ResumeData.email, context),
             const SizedBox(width: 28),
             _buildFooterLink('LINKEDIN', ResumeData.linkedin, context),
             const SizedBox(width: 28),
             _buildFooterLink('GITHUB', ResumeData.github, context),
             const SizedBox(width: 28),
             _buildFooterLink('WEBSITE', ResumeData.website, context),
           ],
        ),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      children: [
        _buildLogo(context),
        const SizedBox(height: 28),
        Wrap(
          spacing: 24,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            _buildFooterLink('EMAIL', ResumeData.email, context),
            _buildFooterLink('LINKEDIN', ResumeData.linkedin, context),
            _buildFooterLink('GITHUB', ResumeData.github, context),
            _buildFooterLink('WEBSITE', ResumeData.website, context),
          ],
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'P',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).textTheme.displayMedium?.color,
              fontSize: context.fontSize(mobile: 22, desktop: 26),
            ),
          ),
          TextSpan(
            text: 'P',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.primary,
              fontSize: context.fontSize(mobile: 22, desktop: 26),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String label, String url, BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri uri = url.startsWith('http')
            ? Uri.parse(url)
            : Uri.parse("https://mail.google.com/mail/?view=cm&fs=1&to=$url&su=Contact from Website&body=Hello");
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
          fontSize: context.fontSize(mobile: 11, desktop: 12),
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }


}

