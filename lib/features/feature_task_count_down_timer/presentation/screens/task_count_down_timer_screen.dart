import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/common/widgets/empty_state_widget.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_un_done_data_status.dart';
import 'package:task_mate/features/feature_task_count_down_timer/presentation/widgets/custom_timer_painter.dart';
import 'package:task_mate/features/feature_task_count_down_timer/presentation/widgets/slidable/action_pane_motions.dart';
import 'package:task_mate/features/feature_task_count_down_timer/presentation/widgets/slidable/actions.dart';
import 'package:task_mate/features/feature_task_count_down_timer/presentation/widgets/slidable/dismissible_pane.dart';
import 'package:task_mate/features/feature_task_count_down_timer/presentation/widgets/slidable/slidable.dart';
import 'package:task_mate/locator.dart';

import '../widgets/count_down_header.dart';

class TaskCountDownTimerScreen extends StatefulWidget {
  const TaskCountDownTimerScreen({super.key});

  @override
  State<TaskCountDownTimerScreen> createState() =>
      _TaskCountDownTimerScreenState();
}

class _TaskCountDownTimerScreenState extends State<TaskCountDownTimerScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isPlaying = false;
  bool isStarting = false;
  int selectedIndex = 0;
  String get timerString {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );

    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isPlaying = false;
          isStarting = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.removeStatusListener((status) {});
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return BlocProvider(
      create: (context) {
        final cubit = TaskCubit(locator());
        cubit.getAllUnDoneTask();
        return cubit;
      },
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [CountDownHeader(themeData: themeData)];
              },
              body: TabBarView(children: [
                CustomScrollView(
                  slivers: [
                    //* Timer
                    SliverPadding(
                      padding: EdgeInsets.only(top: 50.h, bottom: 32.h),
                      sliver: SliverToBoxAdapter(
                        child: AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 244,
                                      width: 244,
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: CustomPaint(
                                                painter: CustomTimerPainter(
                                                    animation: controller,
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                    color: AppColors
                                                        .secondaryColor,
                                                    iconColor:
                                                        AppColors.primaryColor,
                                                    borderThickness: 3,
                                                    borderColor: AppColors
                                                        .primaryColor)),
                                          ),
                                          Align(
                                            alignment: FractionalOffset.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (isPlaying &&
                                                    isStarting) ...{
                                                  Text('توقف',
                                                      style: themeData.textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryTextColor)),
                                                } else if (!isPlaying &&
                                                    isStarting) ...{
                                                  Text('ادامه',
                                                      style: themeData.textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryTextColor)),
                                                } else if (!isStarting) ...{
                                                  Text('شروع',
                                                      style: themeData.textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryTextColor)),
                                                },
                                                SizedBox(
                                                  height: 20.w,
                                                ),
                                                Text(
                                                    timerString
                                                        .toPersianDigit(),
                                                    style: themeData
                                                        .textTheme.titleLarge!
                                                        .copyWith(
                                                            fontFamily: 'SM',
                                                            color: AppColors
                                                                .primaryTextColor)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    AnimatedBuilder(
                                        animation: controller,
                                        builder: (context, child) {
                                          if (!isStarting) {
                                            return Align(
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  minimumSize:
                                                      const Size(107, 36),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                ),
                                                onPressed: () {
                                                  controller.reverse(
                                                      from: controller.value ==
                                                              0.0
                                                          ? 1.0
                                                          : controller.value);
                                                  setState(() {
                                                    isStarting = true;
                                                    isPlaying = true;
                                                  });
                                                },
                                                child: Text(
                                                  'شروع',
                                                  style: themeData
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                              ),
                                            );
                                          }
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor: AppColors
                                                        .secondaryColor,
                                                    minimumSize:
                                                        const Size(107, 36),
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    controller.reset();
                                                    controller.duration =
                                                        Duration.zero;
                                                    setState(() {
                                                      isPlaying = false;
                                                      isStarting = false;
                                                    });
                                                  },
                                                  child: Text('پایان',
                                                      style: themeData
                                                          .textTheme.bodyLarge!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryColor))),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                    minimumSize:
                                                        const Size(107, 36),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                  ),
                                                  onPressed: () {
                                                    if (controller
                                                        .isAnimating) {
                                                      controller.stop();
                                                      setState(() {
                                                        isPlaying = false;
                                                      });
                                                    } else {
                                                      controller.reverse(
                                                          from: controller
                                                                      .value ==
                                                                  0.0
                                                              ? 1.0
                                                              : controller
                                                                  .value);
                                                      setState(() {
                                                        isPlaying = true;
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                    isPlaying
                                                        ? 'توقف'
                                                        : 'ادامه',
                                                    style: themeData
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  )),
                                            ],
                                          );
                                        }),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    //* Done Task List Header
                    SliverPadding(
                      padding: EdgeInsets.only(right: 24.w),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          'شمارنده های ذخیره',
                          style: themeData.textTheme.bodyLarge!
                              .copyWith(color: AppColors.secondaryTextColor),
                        ),
                      ),
                    ),
                    //* Done Task List
                    BlocBuilder<TaskCubit, TaskState>(
                      builder: (context, state) {
                        if (state.taskUndoneDataStatus
                            is TaskUnDoneDataLoading) {
                          return const SliverToBoxAdapter(
                              child: CircularProgressIndicator());
                        }
                        if (state.taskUndoneDataStatus
                            is TasksUnDoneDataEmpty) {
                          return SliverToBoxAdapter(
                              child: EmptyStateWidget(
                            themeData: themeData,
                          ));
                        }
                        if (state.taskUndoneDataStatus
                            is TaskUnDoneDataCompleted) {
                          TaskUnDoneDataCompleted taskUnDoneDataCompleted =
                              state.taskUndoneDataStatus
                                  as TaskUnDoneDataCompleted;
                          final unDoneTaskList =
                              taskUnDoneDataCompleted.unDoneTaskList;
                          final startTimeList =
                              unDoneTaskList.map((e) => e.startTime).toList();
                          final endTimeList =
                              unDoneTaskList.map((e) => e.endTime).toList();
                          return SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            Duration interval = DateTime(
                                    2023,
                                    8,
                                    12,
                                    endTimeList[index].hour!,
                                    endTimeList[index].minute!)
                                .difference(DateTime(
                                    2023,
                                    8,
                                    12,
                                    startTimeList[index].hour!,
                                    startTimeList[index].minute!));

                            String twoDigits(int n) =>
                                n.toString().padLeft(2, "0");
                            String twoDigitMinutes =
                                twoDigits(interval.inMinutes.remainder(60));
                            String twoDigitSeconds =
                                twoDigits(interval.inSeconds.remainder(60));
                            return Slidable(
                              key: UniqueKey(),
                              endActionPane: ActionPane(
                                  dragDismissible: false,
                                  motion: const BehindMotion(),
                                  dismissible: DismissiblePane(onDismissed: () {
                                    debugPrint('dismissed');
                                  }),
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r)),
                                      child: SizedBox(
                                        height: 76.h,
                                        width: 76.w,
                                        child: SlidableAction(
                                          onPressed: (context) {},
                                          backgroundColor:
                                              const Color(0xff5263FC),
                                          foregroundColor: Colors.white,
                                          icon: Image.asset(
                                            'assets/images/edit2.png',
                                            width: 25.w,
                                            height: 25.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r)),
                                      child: SizedBox(
                                        height: 76.h,
                                        width: 76.w,
                                        child: SlidableAction(
                                          onPressed: (context) {},
                                          backgroundColor:
                                              const Color(0xffFF5252),
                                          foregroundColor: Colors.white,
                                          icon: Image.asset(
                                            'assets/images/delete.png',
                                            width: 25.w,
                                            height: 25.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 76.h,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 24.w, vertical: 20.h),
                                decoration: BoxDecoration(
                                    color: AppColors.surfaceColor,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 23,
                                          color: Colors.black.withOpacity(0.02))
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Image.asset(
                                        'assets/images/profile2.png',
                                        width: 56.w,
                                        height: 56.h,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Text(
                                        unDoneTaskList[index].title,
                                        style: themeData.textTheme.bodyMedium!
                                            .copyWith(
                                                color:
                                                    AppColors.primaryTextColor,
                                                fontFamily: 'SB'),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        unDoneTaskList[index].subTitle,
                                        style: themeData.textTheme.bodySmall!
                                            .copyWith(
                                                color: AppColors
                                                    .secondaryTextColor,
                                                fontFamily: 'SN'),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${twoDigits(interval.inHours)}:$twoDigitMinutes:$twoDigitSeconds"
                                            .toPersianDigit(),
                                        style: themeData.textTheme.bodyMedium!
                                            .copyWith(
                                                color:
                                                    AppColors.primaryTextColor,
                                                fontFamily: 'SB'),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            controller.duration = interval;
                                            selectedIndex = index;
                                          });

                                          if (controller.isAnimating) {
                                            controller.stop();
                                            setState(() {
                                              isPlaying = false;
                                            });
                                          } else {
                                            controller.reverse(
                                                from: controller.value == 0.0
                                                    ? 1.0
                                                    : controller.value);
                                            setState(() {
                                              isStarting = true;
                                              isPlaying = true;
                                            });
                                          }
                                        },
                                        child:
                                            isPlaying && selectedIndex == index
                                                ? Image.asset(
                                                    'assets/images/pause.png',
                                                    width: 25.w,
                                                    height: 25.h,
                                                  )
                                                : Image.asset(
                                                    'assets/images/play.png',
                                                    width: 25.w,
                                                    height: 25.h,
                                                  ),
                                      ),
                                      SizedBox(
                                        width: 17.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }, childCount: unDoneTaskList.length));
                        }
                        if (state.taskUndoneDataStatus
                            is TaskUnDoneDataFailed) {
                          TaskUnDoneDataFailed taskUnDoneDataFailed = state
                              .taskUndoneDataStatus as TaskUnDoneDataFailed;
                          final errorMessage = taskUnDoneDataFailed.error;
                          return SliverToBoxAdapter(
                            child: Text(
                              errorMessage,
                              style: themeData.textTheme.bodyLarge!.copyWith(
                                  color: AppColors.secondaryTextColor),
                            ),
                          );
                        }
                        return SliverToBoxAdapter(child: Container());
                      },
                    )
                  ],
                ),
                Container(
                  color: AppColors.primaryColor,
                )
              ])),
        ),
      ),
    );
  }
}
