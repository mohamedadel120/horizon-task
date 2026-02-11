import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/data/models/category_model.dart';
import 'package:task/features/home/presentation/widgets/category_tab.dart';

class CategoryTabs extends StatelessWidget {
  final List<CategoryModel> categories;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final labels = ['All', ...categories.map((c) => c.name)];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          labels.length,
          (index) => Padding(
            padding: EdgeInsets.only(
              right: index < labels.length - 1 ? 12.w : 0,
            ),
            child: CategoryTab(
              label: labels[index],
              isSelected: selectedIndex == index,
              onTap: () => onTabSelected(index),
            ),
          ),
        ),
      ),
    );
  }
}
