import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/home/presentation/widgets/info_row.dart';

class PropertyPricingSection extends StatelessWidget {
  final double basePrice;
  final double cleaningFee;
  final double taxRate;

  const PropertyPricingSection({
    super.key,
    required this.basePrice,
    required this.cleaningFee,
    required this.taxRate,
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
          verticalSpace(12.h),
          InfoRow(
            label: 'Base price',
            value: '\$${basePrice.toStringAsFixed(2)} / night',
          ),
          InfoRow(
            label: 'Cleaning fee',
            value: '\$${cleaningFee.toStringAsFixed(2)}',
          ),
          InfoRow(label: 'Tax rate', value: '${taxRate.toStringAsFixed(0)}%'),
        ],
      ),
    );
  }
}
