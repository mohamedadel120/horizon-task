import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/data/models/product_model.dart';
import 'package:task/features/home/presentation/screens/property_details_screen.dart';
import 'package:task/features/home/presentation/widgets/property_card.dart';
import 'package:task/core/theming/colors.dart';

class PropertyList extends StatelessWidget {
  final List<ProductModel> products;

  const PropertyList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Center(
          child: Text(
            'No products yet',
            style: TextStyle(fontSize: 14.sp, color: ColorManager.grey),
          ),
        ),
      );
    }

    return Column(
      children: products
          .map(
            (product) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: PropertyCard(
                imageUrl: product.imageUrl,
                title: product.title,
                location: product.location,
                price: product.displayPrice,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PropertyDetailsScreen(product: product),
                    ),
                  );
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
