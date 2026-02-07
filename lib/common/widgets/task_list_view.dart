import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mate/common/cubits/task_time_cubit/task_time_cubit.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/common/widgets/empty_state_widget.dart';
import 'package:task_mate/common/widgets/task_list_item.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_un_done_data_status.dart';
import 'package:task_mate/locator.dart';

import '../utils/services/notification_service.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final notificationService = locator<NotificationService>();
  @override
  void dispose() {
    notificationService.streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = locator<TaskCubit>();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = locator<TaskTimeCubit>();
            return cubit;
          },
        ),
      ],
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state.taskUndoneDataStatus is TaskUnDoneDataLoading) {
            return const SliverToBoxAdapter(child: CircularProgressIndicator());
          }
          if (state.taskUndoneDataStatus is TasksUnDoneDataEmpty) {
            return SliverToBoxAdapter(
                child: EmptyStateWidget(
              themeData: widget.themeData,
            ));
          }
          if (state.taskUndoneDataStatus is TaskUnDoneDataCompleted) {
            TaskUnDoneDataCompleted taskUnDoneDataCompleted =
                state.taskUndoneDataStatus as TaskUnDoneDataCompleted;
            final unDoneTaskList = taskUnDoneDataCompleted.unDoneTaskList;

            WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
              await notificationService.startMonitoringTask(unDoneTaskList);
            });
            return SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => GestureDetector(
                          onLongPress: () {
                            context.read<TaskCubit>().deleteTask(
                                unDoneTaskList[index],
                                unDoneTaskList[index].date);
                            context
                                .read<TaskTimeCubit>()
                                .getTaskTimeData(unDoneTaskList[index].date);
                          },
                          child: TaskListItem(
                            themeData: widget.themeData,
                            task: unDoneTaskList[index],
                          ),
                        ),
                    childCount: unDoneTaskList.length));
          }
          if (state.taskUndoneDataStatus is TaskUnDoneDataFailed) {
            TaskUnDoneDataFailed taskUnDoneDataFailed =
                state.taskUndoneDataStatus as TaskUnDoneDataFailed;
            final errorMessage = taskUnDoneDataFailed.error;
            return SliverToBoxAdapter(
              child: Text(
                errorMessage,
                style: widget.themeData.textTheme.bodyLarge!
                    .copyWith(color: AppColors.secondaryTextColor),
              ),
            );
          }
          return SliverToBoxAdapter(child: Container());
        },
      ),
    );
  }
}
