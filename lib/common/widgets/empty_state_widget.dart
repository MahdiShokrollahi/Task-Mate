import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/no_data.svg',
          width: 165.w,
          height: 165.h,
        ),
        Text(
          'تسکی برای نمایش وجود ندارد.',
          style: themeData.textTheme.bodyLarge!
              .copyWith(color: AppColors.secondaryTextColor),
        ),
        SizedBox(
          height: 50.h,
        )
      ],
    );
  }
}
