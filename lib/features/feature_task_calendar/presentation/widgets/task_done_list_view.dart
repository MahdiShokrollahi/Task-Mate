import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/common/cubits/task_time_cubit/task_time_cubit.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/common/widgets/empty_state_widget.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_done_data_status.dart';
import 'package:task_mate/locator.dart';

class TaskDoneListView extends StatefulWidget {
  const TaskDoneListView({super.key, required this.themeData});

  final ThemeData themeData;

  @override
  State<TaskDoneListView> createState() => _TaskDoneListViewState();
}

class _TaskDoneListViewState extends State<TaskDoneListView> {
  bool showTaskDone = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCubit>.value(
          value: locator<TaskCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<TaskTimeCubit>(),
        ),
      ],
      child: SliverList(
          delegate: SliverChildListDelegate([
        GestureDetector(
          onTap: () {
            setState(() {
              showTaskDone = !showTaskDone;
            });
          },
          child: Container(
            height: 32.h,
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.02), blurRadius: 23)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'تسک های انجام شده',
                        style: widget.themeData.textTheme.bodyMedium!
                            .copyWith(color: Colors.black, fontFamily: 'SB'),
                      ),
                    ),
                  ),
                  Image.asset(
                    showTaskDone
                        ? 'assets/images/down_arrow.png'
                        : 'assets/images/up_arrow.png',
                    width: 14.w,
                    height: 8.h,
                  ),
                  SizedBox(
                    width: 15.w,
                  )
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
          if (state.taskDoneDataStatus is TaskDoneDataLoading) {
            return const CircularProgressIndicator();
          }
          if (state.taskDoneDataStatus is TasksDoneDataEmpty && showTaskDone) {
            return EmptyStateWidget(themeData: widget.themeData);
          }
          if (state.taskDoneDataStatus is TaskDoneDataCompleted) {
            TaskDoneDataCompleted taskDoneDataCompleted =
                state.taskDoneDataStatus as TaskDoneDataCompleted;
            var doneTaskList = taskDoneDataCompleted.doneTaskList;
            return SizedBox(
              height: 900,
              child: ListView.builder(
                itemCount: showTaskDone ? doneTaskList.length : 1,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (showTaskDone) {
                    return Stack(
                      children: [
                        Container(
                            height: 132.h,
                            width: 380.w,
                            margin: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 15.h),
                            decoration: BoxDecoration(
                                color: AppColors.surfaceColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      blurRadius: 20)
                                ]),
                            child: Stack(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            20.w, 4.h, 4.w, 4.h),
                                        child: Image.asset(doneTaskList[index]
                                            .taskType
                                            .image)),
                                    Padding(
                                      padding: EdgeInsets.only(top: 15.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(doneTaskList[index].title,
                                              style: widget.themeData.textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                color: Colors.black,
                                                fontFamily: 'SB',
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            doneTaskList[index].subTitle,
                                            style: widget
                                                .themeData.textTheme.bodySmall!
                                                .copyWith(
                                                    fontFamily: 'SN',
                                                    color: const Color(
                                                        0xff1C1F2E)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  bottom: 15.h,
                                  left: 15.w,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6.h, horizontal: 15.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(17.r),
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
                                                style: widget.themeData
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6.h, horizontal: 15.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(17.r),
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
                                                '۱۰:۰۰',
                                                style: widget.themeData
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .secondaryColor),
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
                        Positioned.fill(
                            child: Container(
                          width: 380.w,
                          height: 132.h,
                          margin: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.7),
                                blurRadius: 50,
                              ),
                            ],
                          ),
                        )),
                        Positioned(
                          top: 30.h,
                          left: 40.w,
                          child: GestureDetector(
                            onTap: () {
                              context.read<TaskCubit>().taskChecker(
                                  doneTaskList[index],
                                  doneTaskList[index].date);
                              context
                                  .read<TaskTimeCubit>()
                                  .getTaskTimeData(doneTaskList[index].date);
                            },
                            child: Container(
                              height: 24.h,
                              width: 24.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      color: doneTaskList[index].isDone
                                          ? AppColors.primaryColor
                                          : AppColors.secondaryTextColor,
                                      width: 2.w)),
                              child: doneTaskList[index].isDone
                                  ? Image.asset('assets/images/check_mark.png')
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            );
          }
          if (state.taskDoneDataStatus is TaskDoneDataFailed) {
            TaskDoneDataFailed taskDoneDataFailed =
                state.taskDoneDataStatus as TaskDoneDataFailed;
            return Center(
              child: Text(taskDoneDataFailed.error),
            );
          }
          return Container();
        })
      ])),
    );
  }
}
