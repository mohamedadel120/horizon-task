import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/presentation/widgets/section_title.dart';
import 'package:task/features/home/presentation/widgets/info_row.dart';

class PropertyPricing extends StatelessWidget {
  final String basePrice;
  final String cleaningFee;
  final String taxRate;

  const PropertyPricing({
    super.key,
    required this.basePrice,
    required this.cleaningFee,
    required this.taxRate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Pricing'),
        verticalSpace(12.h),
        InfoRow(label: 'Base price', value: basePrice),
        InfoRow(label: 'Cleaning fee', value: cleaningFee),
        InfoRow(label: 'Tax rate', value: taxRate),
      ],
    );
  }
}
