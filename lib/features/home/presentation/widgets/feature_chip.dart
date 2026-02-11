import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:task/core/theming/colors.dart';

class FeatureChip extends StatelessWidget {
  final String label;

  const FeatureChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),

      decoration: BoxDecoration(
        color: ColorManager.grey200,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          horizontalSpace(1.w),
        ],
      ),
    );
  }
}
