import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/features/feature_home/data/models/my_time_of_day.dart';

class PersianTimePicker extends StatefulWidget {
  const PersianTimePicker(
      {super.key,
      required this.onTimeChanged,
      required this.title,
      this.perviousTime});
  final void Function(TimeOfDay) onTimeChanged;
  final String title;
  final MyTimeOfDay? perviousTime;
  @override
  State<PersianTimePicker> createState() => _PersianTimePickerState();
}

class _PersianTimePickerState extends State<PersianTimePicker> {
  late String currentTime;
  late String currentAMPM;

  @override
  void initState() {
    super.initState();
    currentTime = widget.perviousTime != null
        ? '${widget.perviousTime!.hour}:${widget.perviousTime!.minute}'
        : _getCurrentTime();
    currentAMPM = _formatTime(DateTime.now());
    widget.onTimeChanged(TimeOfDay(
        hour: int.parse(currentTime.split(':')[0]),
        minute: int.parse(currentTime.split(':')[1])));
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final formattedTime = '${now.hour}:${now.minute}';

    return formattedTime;
  }

  String _formatTime(DateTime time) {
    final formatAMPM = DateFormat('a');
    final formattedAMPM = formatAMPM.format(time);
    return formattedAMPM;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final textDriction = Directionality.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: themeData.textTheme.bodyLarge!
                .copyWith(color: AppColors.secondaryTextColor)),
        SizedBox(
          height: 20.h,
        ),
        GestureDetector(
          onTap: () async {
            var picked = await showPersianTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              initialEntryMode: PTimePickerEntryMode.inputOnly,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                      timePickerTheme: TimePickerThemeData(
                        entryModeIconColor: Colors.transparent,
                        dayPeriodColor: WidgetStateColor.resolveWith((states) =>
                            states.contains(WidgetState.selected)
                                ? AppColors.primaryColor
                                : AppColors.secondaryColor),
                        dayPeriodTextStyle: themeData.textTheme.titleLarge,
                        dayPeriodTextColor: WidgetStateColor.resolveWith(
                            (states) => states.contains(WidgetState.selected)
                                ? AppColors.primaryTextColor
                                : AppColors.primaryTextColor),
                        dayPeriodBorderSide:
                            const BorderSide(color: AppColors.primaryTextColor),
                        backgroundColor: AppColors.secondaryColor,
                        hourMinuteColor: WidgetStateColor.resolveWith(
                            (states) => states.contains(WidgetState.selected)
                                ? Colors.blue.withOpacity(0.2)
                                : AppColors.backgroundColor),
                        hourMinuteTextColor: WidgetStateColor.resolveWith(
                            (states) => states.contains(WidgetState.selected)
                                ? Colors.pink
                                : AppColors.primaryTextColor),
                      ),
                      textTheme: TextTheme(
                          labelSmall: themeData.textTheme.bodyLarge!
                              .copyWith(color: AppColors.primaryTextColor)),
                      textButtonTheme: TextButtonThemeData(
                          style: ButtonStyle(
                        textStyle: WidgetStateProperty.all(
                            themeData.textTheme.bodyMedium),
                        foregroundColor: WidgetStateColor.resolveWith(
                            (states) => AppColors.primaryColor),
                        overlayColor: WidgetStateColor.resolveWith(
                            (states) => AppColors.primaryColor),
                      ))),
                  child: MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: Directionality(
                        textDirection: textDriction, child: child!),
                  ),
                );
              },
            );
            if (picked != null) {
              setState(() {
                widget.onTimeChanged(picked);
                currentTime = '${picked.hour}:${picked.minute}';
                final pickedDateTime = DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    picked.hour,
                    picked.minute);
                currentAMPM = _formatTime(pickedDateTime);
              });
            }
          },
          child: Container(
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                border: Border.all(color: AppColors.primaryColor, width: 1)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(currentTime,
                      style: themeData.textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryTextColor,
                      )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(currentAMPM,
                      style: themeData.textTheme.bodyMedium!.copyWith(
                        color: AppColors.secondaryTextColor,
                      )),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down, color: Colors.black)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
