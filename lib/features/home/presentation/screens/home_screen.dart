import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/base/cubit/base_builder_widget.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/home/data/models/home_data_model.dart';
import 'package:task/features/home/logic/home_cubit.dart';
import 'package:task/features/home/logic/home_state.dart';
import 'package:task/features/home/presentation/widgets/home_header.dart';
import 'package:task/features/home/presentation/widgets/search_bar.dart'
    as custom;
import 'package:task/features/home/presentation/widgets/category_tabs.dart';
import 'package:task/features/home/presentation/widgets/section_header.dart';
import 'package:task/features/home/presentation/widgets/property_list.dart';
import 'package:task/features/home/presentation/widgets/home_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: BaseBlocBuilder<HomeCubit, HomeState, HomeDataModel>(
          endPoint: HomeCubit.loadHomeData,
          fakeDataForShimmer: const HomeDataModel(
            categories: [],
            products: [],
          ).fakeData(),
          buildWhen: (previous, current) {
            // Rebuild if status changes OR selected category changes
            return previous.getApiState(HomeCubit.loadHomeData).status !=
                    current.getApiState(HomeCubit.loadHomeData).status ||
                previous.selectedCategoryIndex != current.selectedCategoryIndex;
          },
          builder: (context, data) {
            final state = context.read<HomeCubit>().state;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(16.h),
                    HomeHeader(
                      userName: state.userName,
                      avatarUrl: state.avatarUrl,
                    ),
                    verticalSpace(24.h),
                    const custom.SearchBar(),
                    verticalSpace(24.h),
                    CategoryTabs(
                      categories: data.categories,
                      selectedIndex: state.selectedCategoryIndex,
                      onTabSelected: (index) {
                        context.read<HomeCubit>().selectCategory(index);
                      },
                    ),
                    verticalSpace(24.h),
                    SectionHeader(title: 'Recommended', onSeeAllPressed: () {}),
                    verticalSpace(16.h),
                    PropertyList(products: data.products),
                    verticalSpace(80.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) => setState(() => _selectedNavIndex = index),
      ),
    );
  }
}
