import 'package:equatable/equatable.dart';
import 'package:task_mate/features/feature_home/data/models/task.dart';

abstract class TaskDoneDataStatus extends Equatable {}

class TaskDoneDataLoading extends TaskDoneDataStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TaskDoneDataCompleted extends TaskDoneDataStatus {
  final List<TaskModel> doneTaskList;

  TaskDoneDataCompleted({required this.doneTaskList});

  @override
  // TODO: implement props
  List<Object?> get props => [doneTaskList];
}

class TasksDoneDataEmpty extends TaskDoneDataStatus {
  @override
  List<Object?> get props => [];
}

class TaskDoneDataFailed extends TaskDoneDataStatus {
  final String error;

  TaskDoneDataFailed({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
