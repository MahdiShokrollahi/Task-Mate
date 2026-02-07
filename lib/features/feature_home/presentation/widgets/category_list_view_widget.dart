import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/common/functions/get_task_type_list.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/config/routes/app_routes.dart';
import 'package:task_mate/config/routes/task_list_screen_argument.dart';

class CategoryListViewWidget extends StatelessWidget {
  const CategoryListViewWidget({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: 200.h,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 24.w, bottom: 32.h),
          itemCount: getTaskTypeList().length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.taskListScreen,
                    arguments: TaskListScreenArgument(
                        sortId: getTaskTypeList()[index].sortId));
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      child: Image.asset(
                        getTaskTypeList()[index].categoryImage,
                        height: 200.h,
                        width: 130.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      right: 15,
                      child: Container(
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: AppColors.surfaceColor,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Center(
                          child: Text(
                            getTaskTypeList()[index].title,
                            style: themeData.textTheme.bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    ));
  }
}
