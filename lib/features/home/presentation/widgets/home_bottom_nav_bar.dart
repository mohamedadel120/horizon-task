import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/core/utils/constants/assets/app_icons.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const HomeBottomNavBar({super.key, this.currentIndex = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: ColorManager.mainColor,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(fontSize: 12.sp),
      items: [
        _buildNavItem(
          icon: AppIcons.HOME,
          activeIcon: AppIcons.HOME,
          label: 'Home',
          isSelected: currentIndex == 0,
        ),
        _buildNavItem(
          icon: AppIcons.EXPLORE,
          activeIcon: AppIcons.EXPLORE,
          label: 'Explore',
          isSelected: currentIndex == 1,
        ),
        _buildNavItem(
          icon: AppIcons.SAVED,
          activeIcon: AppIcons.SAVED,
          label: 'Saved',
          isSelected: currentIndex == 2,
        ),
        _buildNavItem(
          icon: AppIcons.PROFILE,
          activeIcon: AppIcons.PROFILE,
          label: 'Profile',
          isSelected: currentIndex == 3,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String icon,
    required String activeIcon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        width: 24.w,
        height: 24.h,
        colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        activeIcon,
        width: 24.w,
        height: 24.h,
        colorFilter: ColorFilter.mode(ColorManager.mainColor, BlendMode.srcIn),
      ),
      label: label,
    );
  }
}
