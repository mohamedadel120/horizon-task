import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/presentation/widgets/property_card.dart';
import 'package:task/features/home/presentation/screens/property_details_screen.dart';

class PropertyList extends StatelessWidget {
  const PropertyList({super.key});

  @override
  Widget build(BuildContext context) {
    final properties = [
      {
        'image':
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400',
        'title': 'Modern Loft',
        'location': 'Central District',
        'price': '\$120/night',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=400',
        'title': 'Woodland Cabin',
        'location': 'North Hills',
        'price': '\$85/night',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400',
        'title': 'Beachside Suite',
        'location': 'Coastal Bay',
        'price': '\$200/night',
      },
    ];

    return Column(
      children: properties
          .map(
            (property) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: PropertyCard(
                imageUrl: property['image']!,
                title: property['title']!,
                location: property['location']!,
                price: property['price']!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyDetailsScreen(
                        title: property['title']!,
                        location: property['location']!,
                        price: property['price']!,
                        imageUrl: property['image']!,
                      ),
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
