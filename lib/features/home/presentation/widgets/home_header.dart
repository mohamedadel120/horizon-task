import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning,',
              style: TextStyle(fontSize: 14.sp, color: ColorManager.grey),
            ),
            Text(
              userName,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.black,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 24.r,
          backgroundImage: avatarUrl.isNotEmpty
              ? NetworkImage(avatarUrl)
              : null,
          child: avatarUrl.isEmpty
              ? Icon(Icons.person, size: 24.r, color: Colors.grey)
              : null,
        ),
      ],
    );
  }
}
