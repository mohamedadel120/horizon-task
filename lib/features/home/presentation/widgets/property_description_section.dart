import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/home/presentation/widgets/feature_chip.dart';

class PropertyDescriptionSection extends StatelessWidget {
  final String description;
  final List<String> features;

  const PropertyDescriptionSection({
    super.key,
    required this.description,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.grey300.withValues(alpha: .8),
          width: .5.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          verticalSpace(12.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorManager.secondColor,
              height: 1.5,
            ),
          ),
          verticalSpace(7.h),
          Wrap(
            spacing: 4.w,
            runSpacing: 4.h,
            children: const [
              FeatureChip(label: '2 Bedrooms'),
              FeatureChip(label: '1 Bath'),
              FeatureChip(label: 'Wi-Fi'),
              FeatureChip(label: 'Pet Friendly'),
              FeatureChip(label: 'Fireplace'),
            ],
          ),
        ],
      ),
    );
  }
}
