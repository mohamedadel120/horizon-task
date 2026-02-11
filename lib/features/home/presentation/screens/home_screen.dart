import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/di/dependency_injection.dart';
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
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..loadCategoriesAndProducts(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      const HomeHeader(
                        userName: 'Sarah Miller',
                        avatarUrl: 'https://i.pravatar.cc/150?img=5',
                      ),
                      SizedBox(height: 24.h),
                      const custom.SearchBar(),
                      SizedBox(height: 24.h),
                      CategoryTabs(
                        categories: state.categories,
                        selectedIndex: state.selectedCategoryIndex,
                        onTabSelected: (index) {
                          context.read<HomeCubit>().selectCategory(index);
                        },
                      ),
                      SizedBox(height: 24.h),
                      SectionHeader(
                        title: 'Recommended',
                        onSeeAllPressed: () {},
                      ),
                      SizedBox(height: 16.h),
                      if (state.errorMessage != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Text(
                            state.errorMessage!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      if (state.isLoading && state.products.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else
                        PropertyList(products: state.products),
                      SizedBox(height: 80.h),
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
      ),
    );
  }
}
