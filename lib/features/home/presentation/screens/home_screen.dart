import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  int _selectedTabIndex = 0;
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  selectedIndex: _selectedTabIndex,
                  onTabSelected: (index) {
                    setState(() => _selectedTabIndex = index);
                  },
                ),
                SizedBox(height: 24.h),
                SectionHeader(title: 'Recommended', onSeeAllPressed: () {}),
                SizedBox(height: 16.h),
                const PropertyList(),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) => setState(() => _selectedNavIndex = index),
      ),
    );
  }
}
