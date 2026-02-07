import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:task_mate/common/cubits/task_time_cubit/task_time_cubit.dart';
import 'package:task_mate/common/functions/get_task_type_list.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/features/feature_home/data/models/my_time_of_day.dart';
import 'package:task_mate/features/feature_home/data/models/persian_date.dart';
import 'package:task_mate/features/feature_home/data/models/task.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';
import 'package:task_mate/features/task_editor_feature/presentation/widgets/persian_date_picker.dart';
import 'package:task_mate/features/task_editor_feature/presentation/widgets/persian_time_picker.dart';

class TaskEditorScreen extends StatefulWidget {
  const TaskEditorScreen({super.key, this.taskModel});
  final TaskModel? taskModel;
  @override
  State<TaskEditorScreen> createState() => _TaskEditorScreenState();
}

class _TaskEditorScreenState extends State<TaskEditorScreen> {
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  Jalali? selectedDate;

  int? selectedIndex;
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.taskModel?.title);
    descriptionController =
        TextEditingController(text: widget.taskModel?.subTitle);
    selectedIndex =
        widget.taskModel != null ? widget.taskModel!.taskType.sortId : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 32.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskModel != null ? 'آپدیت تسک' : 'تسک جدید',
                  style: themeData.textTheme.headlineSmall!.copyWith(
                    color: AppColors.primaryTextColor,
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  'تصویر',
                  style: themeData.textTheme.bodyLarge!
                      .copyWith(color: AppColors.secondaryTextColor),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 116.h,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: getTaskTypeList().length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            width: 116.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5.w,
                                color: selectedIndex == index
                                    ? AppColors.primaryColor
                                    : AppColors.secondaryTextColor,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            margin: EdgeInsets.only(left: 15.w),
                            child: Image.asset(
                                'assets/images/${getTaskTypeList()[index].image}.png'),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  'نام',
                  style: themeData.textTheme.bodyLarge!
                      .copyWith(color: AppColors.secondaryTextColor),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: 'نام تسک پیشنهادی خود را وارد کنید',
                          hintStyle: themeData.textTheme.bodySmall!.copyWith(
                            color: AppColors.primaryTextColor,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 161, 228, 211),
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ))),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  'توضیحات',
                  style: themeData.textTheme.bodyLarge!
                      .copyWith(color: AppColors.secondaryTextColor),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(left: 40.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    border: Border.all(color: AppColors.secondaryTextColor),
                  ),
                  child: TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLines: 5,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                PersianDatePicker(
                  perviousDate: widget.taskModel?.date,
                  onDateChanged: (date) {
                    selectedDate = date;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 1.h,
                  color: const Color.fromARGB(255, 214, 216, 219),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: PersianTimePicker(
                        perviousTime: widget.taskModel?.startTime,
                        onTimeChanged: (time) {
                          selectedStartTime = time;
                        },
                        title: 'زمان شروع',
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: PersianTimePicker(
                        perviousTime: widget.taskModel?.endTime,
                        onTimeChanged: (time) {
                          selectedEndTime = time;
                        },
                        title: 'زمان پایان',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80.h,
                ),
                BlocBuilder<TaskTimeCubit, TaskTimeState>(
                  builder: (context, state) {
                    return Center(
                      child: ElevatedButton(
                          onPressed: () {
                            widget.taskModel?.title = nameController.text;
                            widget.taskModel?.subTitle =
                                descriptionController.text;
                            widget.taskModel?.endTime =
                                MyTimeOfDay.fromTimeOfDay(selectedEndTime!);
                            widget.taskModel?.date =
                                PersianDate.fromJalali(selectedDate!);
                            widget.taskModel?.taskType =
                                getTaskTypeList()[selectedIndex!];
                            widget.taskModel?.startTime =
                                MyTimeOfDay.fromTimeOfDay(selectedStartTime!);

                            if (widget.taskModel != null) {
                              context.read<TaskCubit>().createOrUpdateTask(
                                  widget.taskModel!, widget.taskModel!.date);
                              context
                                  .read<TaskTimeCubit>()
                                  .getTaskTimeData(widget.taskModel!.date);
                            } else {
                              context.read<TaskCubit>().createOrUpdateTask(
                                  TaskModel(
                                      title: nameController.text,
                                      subTitle: descriptionController.text,
                                      endTime: MyTimeOfDay.fromTimeOfDay(
                                          selectedEndTime!),
                                      date:
                                          PersianDate.fromJalali(selectedDate!),
                                      taskType:
                                          getTaskTypeList()[selectedIndex!],
                                      startTime: MyTimeOfDay.fromTimeOfDay(
                                          selectedStartTime!)),
                                  PersianDate.fromJalali(selectedDate!));
                              context.read<TaskTimeCubit>().getTaskTimeData(
                                  PersianDate.fromJalali(selectedDate!));
                            }

                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              minimumSize:
                                  WidgetStateProperty.all(Size(240.w, 50.h)),
                              backgroundColor: WidgetStateProperty.all(
                                  AppColors.primaryColor),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.r))),
                              padding: WidgetStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 10.h))),
                          child: const Text('اضافه')),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
