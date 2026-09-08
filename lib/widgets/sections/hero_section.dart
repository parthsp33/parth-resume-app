import 'package:flutter/material.dart';
import '../../const/color.dart';
import '../../config/resume_data.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/external_links.dart';
import '../../main.dart'; // Import themeNotifier
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
                  tooltip: mode == ThemeMode.light
                      ? 'Switch to dark theme'
                      : 'Switch to light theme',
                  icon: Icon(
                    mode == ThemeMode.light ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.75),
                    size: 24,
                  ),
                  onPressed: () {
                    themeNotifier.value = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              ),
              
              // Side Social Sidebar
              if (context.isDesktop)
                Positioned(
                  right: context.gutter,
                  top: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildEmailIcon(Icons.email_outlined, ResumeData.email, context),
                      const SizedBox(height: 12),
                      _buildSocialIcon(
                          Icons.link, ResumeData.linkedin, 'LinkedIn profile', context),
                      const SizedBox(height: 12),
                      _buildSocialIcon(
                          Icons.code, ResumeData.github, 'GitHub profile', context),
                      const SizedBox(height: 12),
                      _buildSocialIcon(
                          Icons.public, ResumeData.website, 'Personal website', context),
                      const SizedBox(height: 12),
                      _buildPhoneIcon(Icons.phone_outlined, ResumeData.mobile, context),
                      const SizedBox(height: 24),
                      Container(
                        width: 1,
                        height: 120,
                        color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.1),
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
                              ResumeData.role.split('|').first.trim().toUpperCase(),
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                letterSpacing: isMobile ? 1.5 : 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.space(48)),
                        // Massive Bold Title
                        Text(
                          "${ResumeData.name.split(' ').first}\n${ResumeData.name.split(' ').last}",
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Theme.of(context).textTheme.displayLarge?.color,
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
                            "Building robust, scalable, and user-centric mobile applications with Flutter and Swift.",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                          ],
                        ),
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

  Widget _buildActionButton(String label, bool isPrimary, BuildContext context, {required VoidCallback onPressed}) {
    final isMobile = context.isMobile;
    final bgColor = isPrimary ? Colors.white : Colors.transparent;
    final textColor = isPrimary ? Colors.black : Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = isPrimary ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.2);

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
          border: isPrimary ? null : Border.all(color: borderColor ?? Colors.grey),
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



  /// One labelled, 44px-minimum tap target for every sidebar icon.
  ///
  /// The icons carry no text, so without an explicit label a screen reader
  /// announces nothing useful. 22px on its own is also well under the
  /// recommended touch size, hence the padding.
  Widget _buildIconLink({
    required IconData icon,
    required String label,
    required Uri uri,
    required BuildContext context,
  }) {
    return Semantics(
      button: true,
      label: label,
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: () => ExternalLinks.openOrNotify(context, uri),
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(11),
            child: Icon(
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
      IconData icon, String url, String label, BuildContext context) {
    return _buildIconLink(
      icon: icon,
      label: label,
      uri: Uri.parse(url),
      context: context,
    );
  }

  Widget _buildEmailIcon(IconData icon, String email, BuildContext context) {
    return _buildIconLink(
      icon: icon,
      label: 'Email $email',
      uri: ExternalLinks.gmailCompose(to: email),
      context: context,
    );
  }

  Widget _buildPhoneIcon(IconData icon, String phone, BuildContext context) {
    return _buildIconLink(
      icon: icon,
      label: 'Call $phone',
      uri: ExternalLinks.phone(phone),
      context: context,
    );
  }
}


