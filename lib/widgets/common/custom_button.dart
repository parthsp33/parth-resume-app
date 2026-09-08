import 'package:flutter/material.dart';

import '../../const/color.dart';
import '../../utils/responsive_utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    // Sizes to its label between a sensible min and max. A hard width is
    // itself an overflow source once the label changes.
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: context.responsiveValue(mobile: 150, tablet: 160, desktop: 170),
        minHeight: context.responsiveValue(mobile: 46, tablet: 46, desktop: 44),
        maxWidth: 260,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : AppColors.primary,
          foregroundColor: isOutlined ? AppColors.primary : Colors.white,
          side: isOutlined ? BorderSide(color: AppColors.primary) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 24,
            vertical: isMobile ? 12 : 14,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: context.fontSize(mobile: 15, tablet: 15, desktop: 14),
            fontWeight: isMobile ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
