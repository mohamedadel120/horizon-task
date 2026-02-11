import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/core/utils/constants/assets/app_icons.dart';

class PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onTap;

  const PropertyCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    this.onFavoritePressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.propertyCardBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorManager.grey200),
        ),
        child: Row(
          children: [
            _buildImage(),
            horizontalSpace(16.w),
            _buildDetails(),
            _buildFavoriteButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.network(
        imageUrl,
        width: 64.w,
        height: 64.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 64.w,
            height: 64.h, // Fixed height to match image
            color: ColorManager.grey200,
            padding: EdgeInsets.all(12.w),
            child: SvgPicture.asset(
              AppIcons.HOME,
              colorFilter: const ColorFilter.mode(
                ColorManager.grey400,
                BlendMode.srcIn,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetails() {
    final displayTitle = title.trim().isEmpty ? 'No Title' : title.trim();
    final displayLocation = location.trim().isEmpty
        ? 'Horizon'
        : location.trim();
    final displayPrice = price.trim().isEmpty ? '' : price.trim();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            displayTitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ColorManager.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(8.h),
          Text(
            displayPrice.isNotEmpty
                ? '$displayLocation • $displayPrice'
                : displayLocation,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: ColorManager.secondColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return InkWell(
      onTap: onFavoritePressed,
      borderRadius: BorderRadius.circular(20.r),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: SvgPicture.asset(
          AppIcons.HEART_LINE,
          width: 20.w,
          height: 20.w,
          colorFilter: const ColorFilter.mode(
            ColorManager.secondColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
