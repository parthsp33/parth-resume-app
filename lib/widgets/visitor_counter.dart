import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/visitor_service.dart';
import '../../const/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VisitorCounter extends StatelessWidget {
  const VisitorCounter({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 700;

    return StreamBuilder<int>(
      stream: VisitorService().getVisitorCountStream(),
      builder: (context, snapshot) {
        // We only want to show the counter if we have data
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink(); 
        }

        final int count = snapshot.data!;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.eye,
                size: isMobile ? 12.sp : 14.sp,
                color: AppColors.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                '$count Views',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 12 : 14.sp,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
