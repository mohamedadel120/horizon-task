import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/presentation/widgets/section_title.dart';
import 'package:task/features/home/presentation/widgets/info_row.dart';

class PropertyOrganization extends StatelessWidget {
  final String category;
  final String tags;

  const PropertyOrganization({
    super.key,
    required this.category,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Organization'),
        SizedBox(height: 12.h),
        InfoRow(label: 'Category', value: category),
        InfoRow(label: 'Tags', value: tags),
      ],
    );
  }
}
