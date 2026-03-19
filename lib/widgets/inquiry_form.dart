import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/resume_data.dart';
import '../const/color.dart';
import '../services/inquiry_service.dart';
import '../utils/responsive_utils.dart';

class InquiryForm extends StatefulWidget {
  const InquiryForm({super.key});

  @override
  State<InquiryForm> createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  String? _projectType;
  String? _budgetRange;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  InputDecoration _decoration(BuildContext context, String hint) {
    final borderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.black.withValues(alpha: 0.08);

    final fillColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.surfaceDark.withValues(alpha: 0.35)
        : AppColors.surfaceLight;

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.55),
        fontSize: context.isMobile ? 14 : 14.sp,
      ),
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary.withValues(alpha: 0.75), width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.7)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.9), width: 1.2),
      ),
    );
  }

  Widget _label(BuildContext context, String text, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        required ? '$text *' : text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.55),
              letterSpacing: 2,
              fontSize: context.isMobile ? 11 : 11.sp,
            ),
      ),
    );
  }

  String? _requiredText(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  String? _emailValidator(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Required';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
    if (!ok) return 'Enter a valid email';
    return null;
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isSubmitting = true);
    try {
      final result = await InquiryService().saveInquiry(
        InquiryPayload(
          firstName: _firstName.text.trim(),
          lastName: _lastName.text.trim(),
          email: _email.text.trim(),
          projectType: _projectType ?? '',
          budgetRange: _budgetRange,
          message: _message.text.trim(),
        ),
      );

      if (result.sheetSaved == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Google Sheet webhook not configured. Add /exec URL in inquiry_sheet_config.dart.',
              ),
              backgroundColor: Colors.orange.shade800,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
            ),
          );
        }
        return;
      }

      if (result.sheetSaved == false) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Could not submit inquiry to Google Sheet (webhook/CORS issue).',
              ),
              backgroundColor: Colors.red.shade800,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
            ),
          );
        }
        return;
      }

      final subject = Uri.encodeComponent('New inquiry from ${_firstName.text.trim()} ${_lastName.text.trim()}');
      final body = Uri.encodeComponent('''
First name: ${_firstName.text.trim()}
Last name: ${_lastName.text.trim()}
Email: ${_email.text.trim()}
Project type: ${_projectType ?? '-'}
Budget range: ${_budgetRange ?? '-'}

Project details:
${_message.text.trim()}
''');

      final uri = Uri.parse(
        'https://mail.google.com/mail/?view=cm&fs=1&to=${ResumeData.email}&su=$subject&body=$body',
      );

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Inquiry submitted to Google Sheet.'),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    final panelBorder = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.black.withValues(alpha: 0.08);

    final panelBg = Theme.of(context).brightness == Brightness.dark
        ? AppColors.surfaceDark.withValues(alpha: 0.25)
        : Colors.white;

    final projectTypes = const [
      'Mobile App',
      'Web App',
      'UI/UX',
      'Consulting',
      'Other',
    ];

    final budgets = const [
      'Below \$1k',
      '\$1k – \$5k',
      '\$5k – \$10k',
      '\$10k+',
    ];

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 980),
      padding: EdgeInsets.all(isMobile ? 16 : 22.r),
      decoration: BoxDecoration(
        color: panelBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: panelBorder),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isMobile)
              Text(
                'Inquiry Form',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            if (isMobile) SizedBox(height: 18.h),

            // Names row
            if (isMobile) ...[
              _label(context, 'FIRST NAME', required: true),
              TextFormField(
                controller: _firstName,
                validator: _requiredText,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontSize: 14.sp,
                    ),
                decoration: _decoration(context, 'Arjun'),
              ),
              SizedBox(height: 18.h),
              _label(context, 'LAST NAME', required: true),
              TextFormField(
                controller: _lastName,
                validator: _requiredText,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontSize: 14.sp,
                    ),
                decoration: _decoration(context, 'Patel'),
              ),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label(context, 'FIRST NAME', required: true),
                        TextFormField(
                          controller: _firstName,
                          validator: _requiredText,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).textTheme.displayLarge?.color,
                                fontSize: 14.sp,
                              ),
                          decoration: _decoration(context, 'Arjun'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label(context, 'LAST NAME', required: true),
                        TextFormField(
                          controller: _lastName,
                          validator: _requiredText,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).textTheme.displayLarge?.color,
                                fontSize: 14.sp,
                              ),
                          decoration: _decoration(context, 'Patel'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: 22.h),

            _label(context, 'EMAIL ADDRESS', required: true),
            TextFormField(
              controller: _email,
              validator: _emailValidator,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontSize: 14.sp,
                  ),
              decoration: _decoration(context, 'arjun@company.com'),
            ),

            SizedBox(height: 22.h),

            _label(context, 'PROJECT TYPE', required: true),
            DropdownButtonFormField<String>(
              initialValue: _projectType,
              items: projectTypes
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _projectType = v),
              decoration: _decoration(context, 'Select project type'),
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              dropdownColor: Theme.of(context).cardColor,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontSize: 14.sp,
                  ),
              iconEnabledColor: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
            ),

            SizedBox(height: 22.h),

            _label(context, 'BUDGET RANGE'),
            DropdownButtonFormField<String>(
              initialValue: _budgetRange,
              items: budgets
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _budgetRange = v),
              decoration: _decoration(context, 'Select budget range'),
              dropdownColor: Theme.of(context).cardColor,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontSize: 14.sp,
                  ),
              iconEnabledColor: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
            ),

            SizedBox(height: 22.h),

            _label(context, 'TELL ME ABOUT YOUR PROJECT', required: true),
            TextFormField(
              controller: _message,
              validator: _requiredText,
              minLines: 5,
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontSize: 14.sp,
                  ),
              decoration: _decoration(
                context,
                'Describe your project, goals, timeline, and any specific requirements...',
              ),
            ),

            SizedBox(height: 26.h),

            SizedBox(
              height: isMobile ? 52 : 54.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withValues(alpha: Theme.of(context).brightness == Brightness.dark ? 0.75 : 0.85),
                      Colors.black,
                    ],
                  ),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                ),
                child: TextButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    foregroundColor: Colors.white,
                  ),
                  child: _isSubmitting
                      ? SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SEND INQUIRY',
                              style: TextStyle(
                                letterSpacing: 2,
                                fontWeight: FontWeight.w700,
                                fontSize: isMobile ? 12 : 12.sp,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(Icons.arrow_forward, size: isMobile ? 18 : 18.sp),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

