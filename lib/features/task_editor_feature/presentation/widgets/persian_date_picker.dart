import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:task_mate/common/utils/services/date_manager.dart';
import 'package:task_mate/features/feature_home/data/models/persian_date.dart';

import '../../../../common/utils/constants/app_colors.dart';

class PersianDatePicker extends StatefulWidget {
  const PersianDatePicker(
      {super.key, required this.onDateChanged, this.perviousDate});
  final void Function(Jalali) onDateChanged;
  final PersianDate? perviousDate;
  @override
  State<PersianDatePicker> createState() => _PersianDatePickerState();
}

class _PersianDatePickerState extends State<PersianDatePicker> {
  Jalali? dateNow;
  @override
  void initState() {
    dateNow = widget.perviousDate != null
        ? PersianDate(
                year: widget.perviousDate!.year!,
                month: widget.perviousDate!.month!,
                day: widget.perviousDate!.day!)
            .toJalali()
        : Jalali.now();
    widget.onDateChanged(dateNow!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تاریخ',
          style: themeData.textTheme.bodyLarge!
              .copyWith(color: AppColors.secondaryTextColor),
        ),
        SizedBox(
          height: 20.h,
        ),
        GestureDetector(
          onTap: () async {
            final date = await showPersianDatePicker(
              context: context,
              initialDate: Jalali.now(),
              firstDate: Jalali(1402, 1),
              lastDate: Jalali(1450, 12),
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.primaryColor,
                      onPrimary: Colors.white,
                      surface: AppColors.primaryColor,
                      onSurface: Colors.black,
                    ),
                    dialogBackgroundColor: Colors.white,
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              setState(() {
                dateNow = date;
                widget.onDateChanged(dateNow!);
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "${dateNow!.day.toString().toPersianDigit()} - ${DateManager.months[dateNow!.month - 1].toString().toPersianDigit()} - ${dateNow!.year.toString().toPersianDigit()}",
                  style: themeData.textTheme.bodyMedium!.copyWith(
                    color: AppColors.primaryTextColor,
                  )),
              const Icon(Icons.arrow_drop_down, color: Colors.black)
            ],
          ),
        ),
      ],
    );
  }
}
