import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/data/models/product_model.dart';
import 'package:task/features/home/presentation/widgets/property_image_gallery.dart';
import 'package:task/features/home/presentation/widgets/property_details_header.dart';
import 'package:task/features/home/presentation/widgets/property_description_section.dart';
import 'package:task/features/home/presentation/widgets/property_pricing_section.dart';
import 'package:task/features/home/presentation/widgets/property_organization_section.dart';
import 'package:task/features/home/presentation/widgets/property_availability_section.dart';
import 'package:task/features/home/presentation/widgets/property_metadata_section.dart';

import 'package:task/core/theming/colors.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const PropertyDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryBackground,
      appBar: AppBar(
        backgroundColor: ColorManager.primaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: ColorManager.grey300,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Product details',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: ColorManager.grey300),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertyDetailsHeader(title: product.title),
            verticalSpace(16.h),
            PropertyImageGallery(
              mainImage: product.imageUrl,
              thumbnails: [
                product.imageUrl,
                product.imageUrl,
                product.imageUrl,
              ],
            ),
            verticalSpace(16.h),
            PropertyDescriptionSection(
              description: product.description,
              features: product.features,
            ),
            verticalSpace(16.h),
            PropertyPricingSection(
              basePrice: double.parse(product.price),
              cleaningFee: product.cleaningFee,
              taxRate: product.taxRate,
            ),
            verticalSpace(16.h),
            const PropertyOrganizationSection(),
            verticalSpace(16.h),
            const PropertyAvailabilitySection(),
            verticalSpace(16.h),
            PropertyMetadataSection(
              createdAt: product.createdAt,
              updatedAt: product.updatedAt,
            ),
            verticalSpace(80.h),
          ],
        ),
      ),
    );
  }
}
