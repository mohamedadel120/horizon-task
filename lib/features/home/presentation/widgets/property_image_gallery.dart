import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';

class PropertyImageGallery extends StatelessWidget {
  final String mainImage;
  final List<String> thumbnails;

  const PropertyImageGallery({
    super.key,
    required this.mainImage,
    required this.thumbnails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.grey300.withValues(alpha: .8),
          width: .5.w,
        ),
      ),
      child: Column(
        children: [
          // Main Image
          Container(
            height: 240.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.grey300.withValues(alpha: .8),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                mainImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.image,
                      size: 48.sp,
                      color: ColorManager.grey300.withValues(alpha: .8),
                    ),
                  );
                },
              ),
            ),
          ),
          verticalSpace(12.h),
          // Thumbnails
          SizedBox(
            height: 48.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: thumbnails.length,
              separatorBuilder: (context, index) => horizontalSpace(8.w),
              itemBuilder: (context, index) {
                return Container(
                  width: 64.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: index == 0
                          ? ColorManager.mainColor
                          : ColorManager.grey200.withValues(alpha: .8),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.network(thumbnails[index], fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
