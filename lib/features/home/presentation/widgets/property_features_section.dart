import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/presentation/widgets/feature_chip.dart';

class PropertyFeaturesSection extends StatelessWidget {
  const PropertyFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: const [
        FeatureChip(label: '2 Bedrooms'),
        FeatureChip(label: '1 Bath'),
        FeatureChip(label: 'Wi-Fi'),
        FeatureChip(label: 'Pet Friendly'),
        FeatureChip(label: 'Fireplace'),
      ],
    );
  }
}
