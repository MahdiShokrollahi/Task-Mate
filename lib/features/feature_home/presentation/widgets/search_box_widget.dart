import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/config/routes/app_routes.dart';
import 'package:task_mate/config/routes/task_list_screen_argument.dart';

import '../../../../common/utils/constants/app_colors.dart';

class SearchBoxWidget extends StatelessWidget {
  SearchBoxWidget({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        bottom: 32.h,
        left: 24.w,
        right: 24.w,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 46.h,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            left: 15.w,
            right: 10.w,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/search.png',
                  height: 25.h,
                  width: 25.w,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      Navigator.pushNamed(context, AppRoutes.taskListScreen,
                          arguments: TaskListScreenArgument(
                              searchTerm: searchController.text));
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          'جستجوی تسکات ...',
                          style: themeData.textTheme.bodySmall!.copyWith(
                              color: AppColors.secondaryTextColor,
                              fontFamily: 'SB'),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                ),
                Image.asset(
                  'assets/images/filter.png',
                  height: 25.h,
                  width: 25.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
