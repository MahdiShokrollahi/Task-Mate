import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:task_mate/common/cubits/task_time_cubit/task_time_cubit.dart';
import 'package:task_mate/common/cubits/task_time_cubit/task_time_data_status.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/features/feature_home/data/models/my_time_of_day.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';
import 'package:task_mate/locator.dart';

class TimeSelectorSlider extends StatefulWidget {
  const TimeSelectorSlider({super.key, required this.themeData});
  final ThemeData themeData;
  @override
  State<TimeSelectorSlider> createState() => _TimeSelectorSliderState();
}

class _TimeSelectorSliderState extends State<TimeSelectorSlider> {
  double currentSliderValue = 0;
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskTimeCubit>.value(value: locator<TaskTimeCubit>()),
        BlocProvider<TaskCubit>.value(value: locator<TaskCubit>())
      ],
      child: SliverToBoxAdapter(
        child: BlocBuilder<TaskTimeCubit, TaskTimeState>(
          builder: (context, state) {
            if (!state.isStartupComplete) {
              context.read<TaskCubit>().filterTask(date: state.date);
            }
            context.read<TaskTimeCubit>().getTaskTimeData(state.date);
            if (state.taskTimeDataStatus is TaskTimeDataLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.taskTimeDataStatus is TaskTimeDataLoaded) {
              TaskTimeDataLoaded taskTimeDataLoaded =
                  state.taskTimeDataStatus as TaskTimeDataLoaded;

              final startTimeList =
                  removeDuplicates(taskTimeDataLoaded.startTimeOfDayList);
              final endTimeList =
                  removeDuplicates(taskTimeDataLoaded.endTimeOfDayList);

              final startHourList = startTimeList.map((e) => e.hour).toList();
              final startMinuteList =
                  startTimeList.map((e) => e.minute).toList();
              final endHourList = endTimeList.map((e) => e.hour).toList();
              final endMinuteList = endTimeList.map((e) => e.minute).toList();
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: SliderTheme(
                      data: widget.themeData.sliderTheme,
                      child: Slider(
                        value: currentSliderValue,
                        onChanged: (double value) {
                          setState(() {
                            currentSliderValue = value;
                          });
                          scrollController.jumpTo(value * 20);
                          if (value == 0) {
                            context
                                .read<TaskCubit>()
                                .filterTask(date: state.date);
                          } else if (value < startHourList.length) {
                            context.read<TaskCubit>().filterTask(
                                date: state.date,
                                startTime: MyTimeOfDay(
                                    hour: startHourList[value.toInt()],
                                    minute: startMinuteList[value.toInt()]),
                                endTime: MyTimeOfDay(
                                    hour: endHourList[value.toInt()],
                                    minute: endMinuteList[value.toInt()]));
                          } else if (value == startHourList.length) {
                            context.read<TaskCubit>().filterTask(
                                date: state.date,
                                startTime: MyTimeOfDay(
                                    hour: startHourList.last,
                                    minute: startMinuteList.last),
                                endTime: MyTimeOfDay(
                                    hour: endHourList.last,
                                    minute: endMinuteList.last));
                          }
                        },
                        min: 0,
                        max: startHourList.isEmpty
                            ? 0
                            : startHourList.length.toDouble(),
                        activeColor: AppColors.secondaryColor,
                        inactiveColor: AppColors.secondaryColor,
                        thumbColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                    child: ListView.builder(
                        itemCount: startHourList.length + 1,
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(right: 24.w, bottom: 17.h),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentSliderValue = index.toDouble();
                                });
                                scrollController.jumpTo(0);
                                context
                                    .read<TaskCubit>()
                                    .filterTask(date: state.date);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 30.w),
                                child: Text(
                                  'همه',
                                  textAlign: TextAlign.center,
                                  style: widget.themeData.textTheme.bodyLarge!
                                      .copyWith(
                                          color: currentSliderValue ==
                                                  index.toDouble()
                                              ? Colors.black
                                              : AppColors.secondaryTextColor),
                                ),
                              ),
                            );
                          }
                          if (index <= startHourList.length) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentSliderValue = index.toDouble();
                                });
                                scrollController.jumpTo(index.toDouble() * 20);
                                context.read<TaskCubit>().filterTask(
                                    date: state.date,
                                    startTime: MyTimeOfDay(
                                        hour: startHourList[index - 1],
                                        minute: startMinuteList[index - 1]),
                                    endTime: MyTimeOfDay(
                                        hour: endHourList[index - 1],
                                        minute: endMinuteList[index - 1]));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.w),
                                child: Text(
                                  '${endHourList[index - 1]}:${endMinuteList[index - 1]} - ${startHourList[index - 1]}:${startMinuteList[index - 1]}'
                                      .toPersianDigit(),
                                  textAlign: TextAlign.center,
                                  style: widget.themeData.textTheme.bodyLarge!
                                      .copyWith(
                                          color: currentSliderValue ==
                                                  index.toDouble()
                                              ? Colors.black
                                              : AppColors.secondaryTextColor),
                                ),
                              ),
                            );
                          }
                          return Container();
                        }),
                  )
                ],
              );
            }
            if (state.taskTimeDataStatus is TaskTimeDataError) {
              return Center(
                  child: Text(
                      (state.taskTimeDataStatus as TaskTimeDataError).message));
            }
            return Container();
          },
        ),
      ),
    );
  }

  List<MyTimeOfDay> removeDuplicates(List<MyTimeOfDay> list) {
    Map<int, MyTimeOfDay> uniqueMap = {};

    for (MyTimeOfDay time in list) {
      if (!uniqueMap.containsKey(time.hour)) {
        uniqueMap[time.hour!] = time;
      }
    }

    return uniqueMap.values.toList();
  }
}
