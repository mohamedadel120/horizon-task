import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.h),
        Center(
          child: Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: ColorManager.mainColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.hexagon_outlined,
              size: 36.sp,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 32.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
