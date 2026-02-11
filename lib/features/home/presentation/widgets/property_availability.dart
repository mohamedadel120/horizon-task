import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:task/features/home/presentation/widgets/section_title.dart';
import 'package:task/features/home/presentation/widgets/info_row.dart';

class PropertyAvailability extends StatelessWidget {
  final bool instantBook;
  final int minNights;
  final int maxGuests;

  const PropertyAvailability({
    super.key,
    required this.instantBook,
    required this.minNights,
    required this.maxGuests,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Availability'),
        verticalSpace(12.h),
        InfoRow(
          label: 'Instant book',
          value: instantBook ? 'On' : 'Off',
          valueColor: instantBook ? const Color(0xFF4CAF50) : Colors.grey,
        ),
        InfoRow(label: 'Min nights', value: minNights.toString()),
        InfoRow(label: 'Max guests', value: maxGuests.toString()),
      ],
    );
  }
}
