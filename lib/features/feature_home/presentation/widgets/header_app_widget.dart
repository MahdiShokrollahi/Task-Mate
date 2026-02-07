import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';

class HeaderAppWidget extends StatelessWidget {
  const HeaderAppWidget({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 32.h),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/profile.png',
                  ),
                  SizedBox(width: 15.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'سلام ،',
                                style: themeData.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.primaryTextColor)),
                            TextSpan(
                                text: 'مهدی',
                                style: themeData.textTheme.bodyLarge!
                                    .copyWith(color: AppColors.primaryColor)),
                          ])),
                          SizedBox(width: 4.w),
                          Image.asset(
                            'assets/images/icon_hi.png',
                          )
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text('۲ شهریور',
                          style: themeData.textTheme.bodySmall!
                              .copyWith(color: AppColors.secondaryTextColor))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 85.w,
              height: 26.h,
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(13.r)),
              child: Center(
                child: Text(
                  '۲۰ تسک فعال',
                  style: themeData.textTheme.bodySmall!.copyWith(
                      fontFamily: 'SB', color: AppColors.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
