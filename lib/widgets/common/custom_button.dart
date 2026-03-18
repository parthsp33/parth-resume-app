import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    return SizedBox(
      width: context.responsiveValue(mobile: 200.w, tablet: 180.w, desktop: 160.w),
      height: context.responsiveValue(mobile: 50.h, tablet: 45.h, desktop: 40.h),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : AppColors.primary,
          foregroundColor: isOutlined ? AppColors.primary : Colors.white,
          side: isOutlined ? BorderSide(color: AppColors.primary) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              context.responsiveValue(mobile: 8.r, tablet: 6.r, desktop: 4.r),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20.w : 16.w,
            vertical: isMobile ? 10.h : 8.h,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: context.responsiveValue(mobile: 16.sp, tablet: 14.sp, desktop: 12.sp),
            fontWeight: isMobile ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
