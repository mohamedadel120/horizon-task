import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/home/presentation/widgets/info_row.dart';

class PropertyOrganizationSection extends StatelessWidget {
  const PropertyOrganizationSection({super.key});

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
            'Organization',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          verticalSpace(12.h),
          const InfoRow(label: 'Category', value: 'Vacation Homes'),
          const InfoRow(label: 'Tags', value: 'Cabin • Forest • Retreat'),
        ],
      ),
    );
  }
}
