import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/color.dart';

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
    // Get screen width to determine device type
    double screenWidth = MediaQuery.of(context).size.width;

    // Define sizes for different screen widths
    double getButtonWidth() {
      if (screenWidth < 600) {
        return 200.w; // Mobile
      } else if (screenWidth < 1100) {
        return 180.w; // Tablet
      } else {
        return 160.w; // Desktop
      }
    }

    double getButtonHeight() {
      if (screenWidth < 600) {
        return 50.h; // Mobile
      } else if (screenWidth < 1100) {
        return 45.h; // Tablet
      } else {
        return 40.h; // Desktop
      }
    }

    double getFontSize() {
      if (screenWidth < 600) {
        return 16.sp; // Mobile
      } else if (screenWidth < 1100) {
        return 14.sp; // Tablet
      } else {
        return 12.sp; // Desktop
      }
    }

    double getBorderRadius() {
      if (screenWidth < 600) {
        return 8.r; // Mobile
      } else if (screenWidth < 1100) {
        return 6.r; // Tablet
      } else {
        return 4.r; // Desktop
      }
    }

    return SizedBox(
      width: getButtonWidth(),
      height: getButtonHeight(),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : AppColors.primary,
          foregroundColor: isOutlined ? AppColors.primary : Colors.white,
          side: isOutlined ? BorderSide(color: AppColors.primary) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(getBorderRadius()),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth < 600 ? 20.w : 16.w,
            vertical: screenWidth < 600 ? 10.h : 8.h,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: getFontSize(),
            fontWeight: screenWidth < 600 ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
