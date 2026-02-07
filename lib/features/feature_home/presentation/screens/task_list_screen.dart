import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/common/functions/get_task_type_list.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/common/widgets/empty_state_widget.dart';
import 'package:task_mate/common/widgets/task_list_item.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_un_done_data_status.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, required this.searchTerm, this.sortId});
  final String searchTerm;
  final int? sortId;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    if (widget.sortId != null) {
      context.read<TaskCubit>().getTaskByCategoryId(widget.sortId!);
    } else {
      context.read<TaskCubit>().getAllUnDoneTask(searchTerm: widget.searchTerm);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.searchTerm.isNotEmpty
              ? 'نتایج جستجو: ${widget.searchTerm}'
              : 'دسته بندی: ${getTaskTypeList()[widget.sortId!].title}',
          style: themeData.textTheme.titleLarge!
              .copyWith(color: AppColors.primaryColor),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state.taskUndoneDataStatus is TaskUnDoneDataLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.taskUndoneDataStatus is TasksUnDoneDataEmpty) {
            return Center(
                child: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2,
                    child: EmptyStateWidget(themeData: themeData)));
          }
          if (state.taskUndoneDataStatus is TaskUnDoneDataCompleted) {
            TaskUnDoneDataCompleted taskUnDoneDataCompleted =
                state.taskUndoneDataStatus as TaskUnDoneDataCompleted;
            final unDoneTaskList = taskUnDoneDataCompleted.unDoneTaskList;
            return ListView.builder(
                itemCount: unDoneTaskList.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 32.h),
                itemBuilder: (context, index) {
                  return TaskListItem(
                      themeData: themeData, task: unDoneTaskList[index]);
                });
          }
          if (state.taskUndoneDataStatus is TaskUnDoneDataFailed) {
            TaskUnDoneDataFailed taskUnDoneDataFailed =
                state.taskUndoneDataStatus as TaskUnDoneDataFailed;
            return Center(
              child: Text(taskUnDoneDataFailed.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}
