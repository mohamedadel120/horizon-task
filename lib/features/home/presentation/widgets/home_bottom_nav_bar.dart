import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/theming/colors.dart';

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
          icon: 'assets/icons/iconify-icon (1).svg',
          activeIcon: 'assets/icons/iconify-icon (1).svg',
          label: 'Home',
          isSelected: currentIndex == 0,
        ),
        _buildNavItem(
          icon: 'assets/icons/SVG.svg',
          activeIcon: 'assets/icons/SVG.svg',
          label: 'Explore',
          isSelected: currentIndex == 1,
        ),
        _buildNavItem(
          icon: 'assets/icons/iconify-icon (2).svg',
          activeIcon: 'assets/icons/iconify-icon (2).svg',
          label: 'Saved',
          isSelected: currentIndex == 2,
        ),
        _buildNavItem(
          icon: 'assets/icons/iconify-icon (3).svg',
          activeIcon: 'assets/icons/iconify-icon (3).svg',
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
