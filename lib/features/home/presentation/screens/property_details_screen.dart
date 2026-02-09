import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/presentation/widgets/property_image_gallery.dart';
import 'package:task/features/home/presentation/widgets/property_details_header.dart';
import 'package:task/features/home/presentation/widgets/property_description_section.dart';
import 'package:task/features/home/presentation/widgets/property_pricing_section.dart';
import 'package:task/features/home/presentation/widgets/property_organization_section.dart';
import 'package:task/features/home/presentation/widgets/property_availability_section.dart';
import 'package:task/features/home/presentation/widgets/property_metadata_section.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String imageUrl;

  const PropertyDetailsScreen({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Product details',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertyDetailsHeader(title: title),
            SizedBox(height: 16.h),
            PropertyImageGallery(
              mainImage: imageUrl,
              thumbnails: [imageUrl, imageUrl, imageUrl],
            ),
            SizedBox(height: 16.h),
            const PropertyDescriptionSection(),
            SizedBox(height: 16.h),
            const PropertyPricingSection(),
            SizedBox(height: 16.h),
            const PropertyOrganizationSection(),
            SizedBox(height: 16.h),
            const PropertyAvailabilitySection(),
            SizedBox(height: 16.h),
            const PropertyMetadataSection(),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}
