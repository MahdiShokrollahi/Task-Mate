import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';
import 'package:task_mate/locator.dart';

class MyPercentIndicator extends StatelessWidget {
  const MyPercentIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>.value(
      value: locator<TaskCubit>(),
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return CircularPercentIndicator(
            radius: 26,
            lineWidth: 4,
            animation: true,
            animationDuration: 1200,
            percent: state.percentCompleted,
            center: Text(
              '%${(state.percentCompleted * 100).round()}'.toPersianDigit(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            progressColor: AppColors.primaryColor,
            backgroundColor: AppColors.secondaryColor,
          );
        },
      ),
    );
  }
}
