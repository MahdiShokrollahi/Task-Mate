import 'package:equatable/equatable.dart';
import 'package:task_mate/features/feature_home/data/models/task.dart';

abstract class TaskUnDoneDataStatus extends Equatable {}

class TaskUnDoneDataLoading extends TaskUnDoneDataStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TaskUnDoneDataCompleted extends TaskUnDoneDataStatus {
  final List<TaskModel> unDoneTaskList;

  TaskUnDoneDataCompleted({required this.unDoneTaskList});

  @override
  // TODO: implement props
  List<Object?> get props => [unDoneTaskList];
}

class TasksUnDoneDataEmpty extends TaskUnDoneDataStatus {
  @override
  List<Object?> get props => [];
}

class TaskUnDoneDataFailed extends TaskUnDoneDataStatus {
  final String error;

  TaskUnDoneDataFailed({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
