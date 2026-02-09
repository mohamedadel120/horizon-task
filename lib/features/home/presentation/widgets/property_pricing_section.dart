import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/home/presentation/widgets/info_row.dart';

class PropertyPricingSection extends StatelessWidget {
  const PropertyPricingSection({super.key});

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
            'Pricing',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          const InfoRow(label: 'Base price', value: '\$85.00 / night'),
          const InfoRow(label: 'Cleaning fee', value: '\$30.00'),
          const InfoRow(label: 'Tax rate', value: '8%'),
        ],
      ),
    );
  }
}
