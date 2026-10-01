import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../config/resume_data.dart';
import '../../utils/external_links.dart';
import '../../services/analytics_service.dart';
import '../../services/contact_service.dart';
import '../../const/color.dart';
import '../section_reveal.dart';
import '../visitor_counter.dart';
import '../../utils/responsive_utils.dart';
import '../common/content_shell.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitContactForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      await ContactService.submitMessage(
        name:
            '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}'
                .trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
      ).timeout(const Duration(seconds: 20));
      if (!mounted) return;
      _firstNameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _messageController.clear();
      AnalyticsService.logContactClick('form_submit');
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not send your message. Please try again.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionGap),
      child: ContentShell(
        child: SectionReveal(
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 760) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildContactIntro(context),
                        SizedBox(height: context.space(48)),
                        _buildContactForm(context),
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _buildContactIntro(context)),
                      const SizedBox(width: 64),
                      Expanded(flex: 6, child: _buildContactForm(context)),
                    ],
                  );
                },
              ),
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

  Widget _buildContactIntro(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.brightness == Brightness.light
        ? AppColors.primaryOnLight
        : AppColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get in Touch',
          style: theme.textTheme.displayMedium,
        ),
        const SizedBox(height: 24),
        Text(
          "I'd love to hear from you!",
          style: theme.textTheme.titleLarge?.copyWith(
            color: accent,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: Text(
            'If you have an inquiry or just want to say hi, send me a message.',
            style: theme.textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: context.space(56)),
        InkWell(
          onTap: () {
            AnalyticsService.logContactClick('email');
            ExternalLinks.openOrNotify(
              context,
              ExternalLinks.gmailCompose(),
            );
          },
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.mail_outline, color: accent, size: 22),
                const SizedBox(width: 14),
                Flexible(
                  child: Text(
                    ResumeData.email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.displayMedium?.color,
                      decoration: TextDecoration.underline,
                      decorationColor: accent.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on_outlined, color: accent, size: 22),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address',
                  style: theme.textTheme.bodySmall?.copyWith(color: accent),
                ),
                Text(ResumeData.address, style: theme.textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildContactSocialLink(
              context,
              'LinkedIn',
              Uri.parse(ResumeData.linkedin),
              FontAwesomeIcons.linkedinIn,
            ),
            const SizedBox(width: 10),
            _buildContactSocialLink(
              context,
              'GitHub',
              Uri.parse(ResumeData.github),
              FontAwesomeIcons.github,
            ),
            const SizedBox(width: 10),
            _buildContactSocialLink(
              context,
              'Website',
              Uri.parse(ResumeData.website),
              FontAwesomeIcons.globe,
            ),
            const SizedBox(width: 10),
            _buildContactSocialLink(
              context,
              'WhatsApp',
              ExternalLinks.whatsapp(),
              FontAwesomeIcons.whatsapp,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactSocialLink(
    BuildContext context,
    String label,
    Uri uri,
    FaIconData icon,
  ) {
    final theme = Theme.of(context);
    final accent = theme.brightness == Brightness.light
        ? AppColors.primaryOnLight
        : AppColors.primary;

    return Tooltip(
      message: label == 'WhatsApp' ? 'Chat on WhatsApp' : label,
      child: IconButton(
        onPressed: () {
          if (label == 'WhatsApp') {
            AnalyticsService.logContactClick('whatsapp');
          } else {
            AnalyticsService.logExternalLink(label.toLowerCase());
          }
          ExternalLinks.openOrNotify(context, uri);
        },
        icon: FaIcon(icon, size: 18),
        color: accent,
        style: IconButton.styleFrom(
          fixedSize: const Size(44, 44),
          side: BorderSide(color: accent.withValues(alpha: 0.22)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final isMobile = context.isMobile;
    final theme = Theme.of(context);
    final outlineColor =
        theme.textTheme.bodyLarge!.color!.withValues(alpha: 0.42);
    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: outlineColor),
    );
    final inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      enabledBorder: fieldBorder,
      border: fieldBorder,
      focusedBorder: fieldBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: fieldBorder.copyWith(
        borderSide: BorderSide(color: theme.colorScheme.error),
      ),
      focusedErrorBorder: fieldBorder.copyWith(
        borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
      ),
      counterText: '',
    );

    Widget firstNameField() => TextFormField(
          controller: _firstNameController,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
          maxLength: 100,
          decoration: inputDecoration.copyWith(labelText: 'First Name'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Enter your first name';
            }
            if ('${value.trim()} ${_lastNameController.text.trim()}'
                    .trim()
                    .length >
                100) {
              return 'Name must be 100 characters or less';
            }
            return null;
          },
        );

    Widget lastNameField() => TextFormField(
          controller: _lastNameController,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          maxLength: 100,
          decoration: inputDecoration.copyWith(labelText: 'Last Name'),
          validator: (value) {
            if ('${_firstNameController.text.trim()} ${value?.trim() ?? ''}'
                    .trim()
                    .length >
                100) {
              return 'Name must be 100 characters or less';
            }
            return null;
          },
        );

    Widget emailField() => TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          maxLength: 254,
          decoration: inputDecoration.copyWith(labelText: 'Email *'),
          validator: (value) {
            final email = value?.trim() ?? '';
            if (email.isEmpty) return 'Enter your email';
            if (email.length > 254 ||
                !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
              return 'Enter a valid email';
            }
            return null;
          },
        );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isMobile)
            firstNameField()
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: firstNameField()),
                const SizedBox(width: 16),
                Expanded(child: lastNameField()),
              ],
            ),
          if (isMobile) ...[
            const SizedBox(height: 8),
            lastNameField(),
          ],
          const SizedBox(height: 8),
          emailField(),
          const SizedBox(height: 8),
          TextFormField(
            controller: _messageController,
            minLines: 4,
            maxLines: 7,
            maxLength: 5000,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.newline,
            decoration: inputDecoration.copyWith(
              labelText: 'Message',
              alignLabelWithHint: true,
            ),
            validator: (value) {
              final message = value?.trim() ?? '';
              if (message.isEmpty) return 'Enter a message';
              if (message.length > 5000) return 'Message is too long';
              return null;
            },
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: isMobile ? double.infinity : 144,
              height: 48,
              child: FilledButton.icon(
                onPressed: _isSubmitting ? null : _submitContactForm,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      AppColors.primary.withValues(alpha: 0.78),
                  disabledForegroundColor: Colors.white,
                ),
                icon: _isSubmitting
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send_outlined, size: 17),
                label: Text(_isSubmitting ? 'Sending' : 'Send'),
              ),
            ),
          ),
        ],
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
}
