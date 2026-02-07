import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:task_mate/common/cubits/task_time_cubit/task_time_cubit.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/common/utils/services/date_manager.dart';
import 'package:task_mate/features/feature_home/data/models/persian_date.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';
import 'package:task_mate/locator.dart';

class CalendarListView extends StatefulWidget {
  const CalendarListView({super.key, required this.themeData});
  final ThemeData themeData;

  @override
  State<CalendarListView> createState() => _CalendarListViewState();
}

class _CalendarListViewState extends State<CalendarListView> {
  int selectedIndex = 0;
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
      child: SliverToBoxAdapter(
        child: SizedBox(
          height: 111.h,
          child: ListView.builder(
            itemCount: DateManager.dates.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(right: 24.w, bottom: 16.h),
            itemBuilder: (context, index) {
              return GestureDetector(onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                context.read<TaskCubit>().filterTask(
                    date: PersianDate.fromJalali(DateManager.dates[index]));
                context.read<TaskTimeCubit>().getTaskTimeData(
                    PersianDate.fromJalali(DateManager.dates[index]));
              }, child: BlocBuilder<TaskTimeCubit, TaskTimeState>(
                builder: (context, state) {
                  return Container(
                    width: 71.w,
                    margin: EdgeInsets.only(left: 20.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                    decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            DateManager
                                .weekdays[DateManager.dates[index].weekDay % 7],
                            style: widget.themeData.textTheme.bodyMedium!
                                .copyWith(
                                    fontFamily: 'SN',
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : AppColors.primaryColor)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                            DateManager.dates[index].day
                                .toString()
                                .toPersianDigit(),
                            style: widget.themeData.textTheme.bodyMedium!
                                .copyWith(
                                    fontFamily: 'SN',
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : AppColors.primaryColor)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Icon(
                          Icons.circle_sharp,
                          size: 5.h,
                          color: selectedIndex == index
                              ? Colors.white
                              : AppColors.primaryColor,
                        )
                      ],
                    ),
                  );
                },
              ));
            },
          ),
        ),
      ),
    );
  }
}
