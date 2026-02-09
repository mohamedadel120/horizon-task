import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/home/presentation/widgets/feature_chip.dart';

class PropertyDescriptionSection extends StatelessWidget {
  const PropertyDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.grey300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Experience the ultimate retreat in this cozy woodland cabin located in the serene North Hills. Perfect for weekend getaways, this property features a rustically modern interior, a wood-burning fireplace, and panoramic views of the surrounding forest.',
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorManager.secondColor,
              height: 1.5,
            ),
          ),
          SizedBox(height: 7.h),
          Wrap(
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
