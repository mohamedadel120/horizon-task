import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/home/presentation/widgets/info_row.dart';

class PropertyMetadataSection extends StatelessWidget {
  const PropertyMetadataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.grey300),
      ),
      child: Column(
        children: [
          InfoRow(
            label: 'Created',
            value: 'Oct 24, 2023',
            valueColor: Colors.grey[600],
          ),
          InfoRow(
            label: 'Last updated',
            value: '2 hours ago',
            valueColor: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}
