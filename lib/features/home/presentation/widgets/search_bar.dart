import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;

  const SearchBar({
    super.key,
    this.hintText = 'Search destinations...',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey[600], size: 20.sp),
            horizontalSpace(12.w),
            Expanded(
              child: Text(
                hintText,
                style: TextStyle(color: Colors.grey[500], fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
