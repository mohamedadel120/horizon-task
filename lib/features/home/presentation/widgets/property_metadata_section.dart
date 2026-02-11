import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/home/presentation/widgets/info_row.dart';

class PropertyMetadataSection extends StatelessWidget {
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PropertyMetadataSection({super.key, this.createdAt, this.updatedAt});

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
          InfoRow(
            label: 'Created',
            value: createdAt != null
                ? '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}'
                : 'N/A',
            valueColor: ColorManager.grey400,
          ),
          InfoRow(
            label: 'Last updated',
            value: updatedAt != null
                ? '${updatedAt!.day}/${updatedAt!.month}/${updatedAt!.year}'
                : 'N/A',
            valueColor: ColorManager.grey400,
          ),
        ],
      ),
    );
  }
}
