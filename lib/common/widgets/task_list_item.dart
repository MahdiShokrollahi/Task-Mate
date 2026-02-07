import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/common/cubits/bottom_navigation_cubit/bottom_navigation_cubit.dart';
import 'package:task_mate/common/cubits/task_time_cubit/task_time_cubit.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/config/routes/app_routes.dart';
import 'package:task_mate/config/routes/edit_task_screen_argument.dart';
import 'package:task_mate/features/feature_home/data/models/task.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.themeData,
    required this.task,
  });

  final ThemeData themeData;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: Container(
          height: 132.h,
          width: 380.w,
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
          decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20)
              ]),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 4.h, 4.w, 4.h),
                      child: Image.asset(
                          'assets/images/${task.taskType.image}.png')),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.title,
                            style: themeData.textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                              fontFamily: 'SB',
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          task.subTitle,
                          style: themeData.textTheme.bodySmall!.copyWith(
                              fontFamily: 'SN', color: const Color(0xff1C1F2E)),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<TaskCubit>().taskChecker(task, task.date);
                      context.read<TaskTimeCubit>().getTaskTimeData(task.date);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.h),
                      child: Container(
                        height: 24.h,
                        width: 24.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                                color: task.isDone
                                    ? AppColors.primaryColor
                                    : AppColors.secondaryTextColor,
                                width: 2.w)),
                        child: task.isDone
                            ? Image.asset('assets/images/check_mark.png')
                            : null,
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 15.h,
                left: 15.w,
                child: Row(
                  children: [
                    BlocBuilder<BottomNavigationCubit, int>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.taskEditorScreen,
                                arguments: EditTaskScreenArgument(
                                  task: task,
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 15.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.r),
                              color: AppColors.secondaryColor,
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/edit.png',
                                    width: 16,
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    'ویرایش',
                                    style: themeData.textTheme.bodySmall!
                                        .copyWith(
                                            color: AppColors.primaryColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.r),
                        color: AppColors.primaryColor,
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/time.png',
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '${task.startTime.hour}:${task.startTime.minute}',
                              style: themeData.textTheme.bodySmall!
                                  .copyWith(color: AppColors.secondaryColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
