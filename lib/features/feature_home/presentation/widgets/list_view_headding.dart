import 'package:flutter/material.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';

class ListViewHeading extends StatelessWidget {
  const ListViewHeading(
      {super.key, required this.title, required this.themeData});
  final String title;
  final ThemeData themeData;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: themeData.textTheme.bodyLarge!.copyWith(
              color: Colors.black,
            )),
        Text('مشاهده بیشتر',
            style: themeData.textTheme.bodySmall!
                .copyWith(color: AppColors.primaryColor, fontFamily: 'SB')),
      ],
    );
  }
}
