import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/utils/constants/app_colors.dart';

class CountDownHeader extends StatelessWidget {
  const CountDownHeader({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          TabBar(
              isScrollable: true,
              indicatorColor: AppColors.primaryColor,
              labelStyle: themeData.textTheme.bodyLarge,
              labelColor: AppColors.primaryTextColor,
              unselectedLabelColor: AppColors.secondaryTextColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(
                  text: 'شمارنده معکوس',
                ),
                Tab(
                  text: 'زمان شمار',
                )
              ]),
          const Spacer(),
          Image.asset(
            'assets/images/settings.png',
            width: 25.w,
            height: 25.h,
          ),
          SizedBox(
            width: 24.w,
          ),
          Image.asset(
            'assets/images/add.png',
            width: 25.w,
            height: 25.h,
          ),
          SizedBox(
            width: 24.w,
          )
        ],
      ),
    );
  }
}
