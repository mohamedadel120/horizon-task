import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/home/presentation/widgets/info_row.dart';

class PropertyAvailabilitySection extends StatelessWidget {
  const PropertyAvailabilitySection({super.key});

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
            'Availability',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          const InfoRow(
            label: 'Instant book',
            value: 'On',
            valueColor: Color(0xFF4CAF50),
          ),
          const InfoRow(label: 'Min nights', value: '2'),
          const InfoRow(label: 'Max guests', value: '4'),
        ],
      ),
    );
  }
}
