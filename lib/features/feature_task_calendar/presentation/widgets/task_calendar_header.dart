import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/features/feature_task_calendar/presentation/widgets/my_percent_indecatro.dart';

import '../../../../common/utils/services/date_manager.dart';

class TaskCalendarHeader extends StatelessWidget {
  const TaskCalendarHeader({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 34.h),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${DateManager.dates.first.day.toString().toPersianDigit()} ${DateManager.months[DateManager.dates.first.month - 1]}',
                    style: themeData.textTheme.bodyLarge!
                        .copyWith(color: Colors.black)),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '۱۰ تسک فعال در امروز',
                  style: themeData.textTheme.bodySmall!
                      .copyWith(color: AppColors.secondaryTextColor),
                )
              ],
            ),
            const Spacer(),
            const MyPercentIndicator(),
            SizedBox(
              width: 24.w,
            ),
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(23.r)),
              child: Center(
                  child: Image.asset(
                'assets/images/calendar.png',
                width: 24.w,
                height: 26.w,
              )),
            )
          ],
        ),
      ),
    );
  }
}
