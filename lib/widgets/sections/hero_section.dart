import 'package:flutter/material.dart';
import '../../const/color.dart';
import '../../config/resume_data.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/external_links.dart';
import '../../main.dart'; // Import themeNotifier
import '../../services/analytics_service.dart';
import '../../services/prefs_service.dart';
import '../hover_scale.dart';
import '../../utils/responsive_utils.dart';
import '../common/content_shell.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewWork;
  final VoidCallback? onContactMe;

  /// Height of the sticky nav, so hero content clears it.
  final double topPadding;

  const HeroSection({
    super.key,
    this.onViewWork,
    this.onContactMe,
    this.topPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        // Use the theme on screen, not the mode, because the mode can be
        // "system". Then one click always flips what the visitor sees.
        final isLight = Theme.of(context).brightness == Brightness.light;

        // Fill the viewport, but never demand more height than the screen
        // actually has. A hard 800px minimum breaks short laptop windows and
        // landscape phones.
        final viewportHeight = context.screenHeight;
        final minHeight = viewportHeight * 0.9 < (isMobile ? 560 : 640)
            ? viewportHeight * 0.9
            : (isMobile ? 560.0 : 640.0);

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: minHeight),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Stack(
            children: [
              // Theme Toggle
              Positioned(
                top: topPadding + 8,
                right: context.gutter,
                child: IconButton(
                  // Names the state it switches to, which is what a screen
                  // reader user needs to hear. The bare icon said nothing.
                  tooltip: isLight
                      ? 'Switch to dark theme'
                      : 'Switch to light theme',
                  icon: Icon(
                    isLight
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.color
                        ?.withValues(alpha: 0.75),
                    size: 24,
                  ),
                  onPressed: () {
                    final nextMode = isLight ? ThemeMode.dark : ThemeMode.light;
                    themeNotifier.value = nextMode;
                    PrefsService.saveThemeMode(nextMode);
                    AnalyticsService.logThemeToggle(nextMode.name);
                  },
                ),
              ),

              // Side Social Sidebar
              if (context.isDesktop)
                Positioned(
                  right: context.gutter,
                  // Start below the theme toggle so the icons never overlap it.
                  top: topPadding + 56,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (final icon in _socialIcons(context)) ...[
                        icon,
                        const SizedBox(height: 4),
                      ],
                      const SizedBox(height: 20),
                      Container(
                        width: 1,
                        height: 80,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.color
                            ?.withValues(alpha: 0.1),
                      ),
                    ],
                  ),
                ),

              // Main Content
              Padding(
                padding: EdgeInsets.only(top: topPadding),
                child: ContentShell(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: () {
                      final children = <Widget>[
                        // Sub-header with line
                        Row(
                          children: [
                            Container(
                              width: isMobile ? 24.0 : 32.0,
                              height: 2,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: isMobile ? 8.0 : 16.0),
                            Text(
                              ResumeData.role
                                  .split('|')
                                  .first
                                  .trim()
                                  .toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    letterSpacing: isMobile ? 1.5 : 3,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.space(48)),
                        // Massive Bold Title
                        Text(
                          "${ResumeData.name.split(' ').first}\n${ResumeData.name.split(' ').last}",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.color,
                                height: 1.1,
                              ),
                        ),
                        SizedBox(height: context.space(40)),
                        // Introduction text
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: isMobile ? double.infinity : 560,
                          ),
                          child: Text(
                            ResumeData.tagline,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      height: 1.6,
                                    ),
                          ),
                        ),
                        SizedBox(height: context.space(56)),
                        // Action Buttons
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            _buildActionButton(
                              'View Portfolio',
                              true,
                              context,
                              onPressed: onViewWork ?? () {},
                            ),
                            _buildActionButton(
                              'Contact Me',
                              false,
                              context,
                              onPressed: onContactMe ?? () {},
                            ),
                            _buildActionButton(
                              'Download CV',
                              false,
                              context,
                              onPressed: () {
                                AnalyticsService.logResumeDownload('hero');
                                ExternalLinks.openOrNotify(
                                  context,
                                  ExternalLinks.resumePdf(),
                                );
                              },
                            ),
                          ],
                        ),
                        // The side bar only fits on desktop, so smaller
                        // screens get the same icons in a row here.
                        if (!context.isDesktop) ...[
                          SizedBox(height: context.space(32)),
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: _socialIcons(context),
                          ),
                        ],
                      ];

                      if (isMobile) return children;

                      return children
                          .animate(interval: 150.ms)
                          .fade(duration: 800.ms)
                          .slideY(
                            begin: 0.1,
                            end: 0,
                            duration: 800.ms,
                            curve: Curves.easeOutCubic,
                          );
                    }(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(String label, bool isPrimary, BuildContext context,
      {required VoidCallback onPressed}) {
    final isMobile = context.isMobile;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    // The primary button used to be white in both themes, which vanished on
    // the white light-theme background. It now inverts with the theme.
    final primaryBg = isDark ? Colors.white : (bodyColor ?? Colors.black);
    final primaryFg = isDark ? Colors.black : Colors.white;
    final bgColor = isPrimary ? primaryBg : Colors.transparent;
    final textColor = isPrimary ? primaryFg : bodyColor;
    final borderColor = bodyColor?.withValues(alpha: 0.2);

    return HoverScale(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 32,
            vertical: isMobile ? 14 : 16,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(100),
            border: isPrimary
                ? null
                : Border.all(color: borderColor ?? Colors.grey),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: context.fontSize(mobile: 15, desktop: 16),
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (isPrimary) ...[
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: textColor, size: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Every contact and social link, in the order they are shown.
  List<Widget> _socialIcons(BuildContext context) => [
        _buildEmailIcon(FontAwesomeIcons.envelope, ResumeData.email, context),
        _buildSocialIcon(FontAwesomeIcons.linkedinIn, ResumeData.linkedin,
            'LinkedIn profile', context),
        _buildSocialIcon(FontAwesomeIcons.github, ResumeData.github,
            'GitHub profile', context),
        _buildWhatsAppIcon(context),
        _buildSocialIcon(FontAwesomeIcons.globe, ResumeData.website,
            'Personal website', context),
        _buildPhoneIcon(FontAwesomeIcons.phone, ResumeData.mobile, context),
      ];

  /// One labelled, 44px-minimum tap target for every sidebar icon.
  ///
  /// The icons carry no text, so without an explicit label a screen reader
  /// announces nothing useful. 22px on its own is also well under the
  /// recommended touch size, hence the padding.
  Widget _buildIconLink({
    required FaIconData icon,
    required String label,
    required Uri uri,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    return Semantics(
      button: true,
      label: label,
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: () {
            onTap?.call();
            ExternalLinks.openOrNotify(context, uri);
          },
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(11),
            child: FaIcon(
              icon,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.color
                  ?.withValues(alpha: 0.75),
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(
      FaIconData icon, String url, String label, BuildContext context) {
    return _buildIconLink(
      icon: icon,
      label: label,
      uri: Uri.parse(url),
      context: context,
    );
  }

  Widget _buildEmailIcon(FaIconData icon, String email, BuildContext context) {
    return _buildIconLink(
      icon: icon,
      label: 'Email $email',
      uri: ExternalLinks.gmailCompose(to: email),
      context: context,
    );
  }

  Widget _buildWhatsAppIcon(BuildContext context) {
    return _buildIconLink(
      icon: FontAwesomeIcons.whatsapp,
      label: 'Chat on WhatsApp',
      uri: ExternalLinks.whatsapp(),
      context: context,
      onTap: () => AnalyticsService.logContactClick('whatsapp'),
    );
  }

  Widget _buildPhoneIcon(FaIconData icon, String phone, BuildContext context) {
    return _buildIconLink(
      icon: icon,
      label: 'Call $phone',
      uri: ExternalLinks.phone(phone),
      context: context,
    );
  }
}
