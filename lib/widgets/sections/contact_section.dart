import 'package:flutter/material.dart';
import '../../config/resume_data.dart';
import '../../utils/external_links.dart';
import '../../services/analytics_service.dart';
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
                child: Semantics(
                  button: true,
                  label: 'Get in touch by email',
                  child: InkWell(
                    onTap: () {
                      AnalyticsService.logContactClick('email');
                      ExternalLinks.openOrNotify(
                        context,
                        ExternalLinks.gmailCompose(),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 32 : 44, vertical: 20),
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
                              fontSize:
                                  context.fontSize(mobile: 17, desktop: 19),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.arrow_forward,
                              color: Colors.white, size: 22),
                        ],
                      ),
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
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color
                    ?.withValues(alpha: 0.05),
              ),
              const SizedBox(height: 28),
              if (isMobile)
                Column(
                  children: [
                    const VisitorCounter(),
                    const SizedBox(height: 12),
                    _buildBuiltWith(context, TextAlign.center),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildBuiltWith(context, TextAlign.start),
                    const VisitorCounter(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBuiltWith(BuildContext context, TextAlign align) {
    return Text(
      'Built with Flutter',
      textAlign: align,
      style: TextStyle(
        // Was alpha 0.3, which is far below the 4.5:1 contrast minimum.
        color: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.color
            ?.withValues(alpha: 0.7),
        fontSize: 12,
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
            const SizedBox(width: 28),
            _buildWhatsAppLink(context),
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
            _buildWhatsAppLink(context),
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
    final uri = url.startsWith('http')
        ? Uri.parse(url)
        : ExternalLinks.gmailCompose(to: url);

    return Semantics(
      link: true,
      label: '$label, opens in a new tab',
      child: InkWell(
        onTap: () {
          AnalyticsService.logExternalLink(label.toLowerCase());
          ExternalLinks.openOrNotify(context, uri);
        },
        child: Padding(
          // Was a bare Text, so the tap target was only as tall as the glyphs.
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            label,
            style: TextStyle(
              // Was alpha 0.5 at 11px bold, under the contrast minimum.
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.color
                  ?.withValues(alpha: 0.8),
              fontSize: context.fontSize(mobile: 11, desktop: 12),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWhatsAppLink(BuildContext context) {
    return Semantics(
      link: true,
      label: 'Connect on WhatsApp at ${ResumeData.whatsappDisplay}',
      child: InkWell(
        onTap: () {
          AnalyticsService.logContactClick('whatsapp');
          ExternalLinks.openOrNotify(context, ExternalLinks.whatsapp());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF25D366),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.chat,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Connect on WhatsApp\n${ResumeData.whatsappDisplay}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withValues(alpha: 0.8),
                  fontSize: context.fontSize(mobile: 10, desktop: 11),
                  fontWeight: FontWeight.bold,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
