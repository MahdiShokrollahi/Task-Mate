// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_cubit.dart';

@immutable
class TaskState extends Equatable {
  final TaskDoneDataStatus taskDoneDataStatus;
  final TaskUnDoneDataStatus taskUndoneDataStatus;
  double percentCompleted;

  TaskState(
      {required this.percentCompleted,
      required this.taskUndoneDataStatus,
      required this.taskDoneDataStatus});

  TaskState copyWith(
      {TaskDoneDataStatus? newTaskDoneDataStatus,
      TaskUnDoneDataStatus? newTaskUndoneDataStatus,
      double? newPercentCompleted}) {
    return TaskState(
      percentCompleted: newPercentCompleted ?? percentCompleted,
      taskDoneDataStatus: newTaskDoneDataStatus ?? taskDoneDataStatus,
      taskUndoneDataStatus: newTaskUndoneDataStatus ?? taskUndoneDataStatus,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [percentCompleted, taskDoneDataStatus, taskUndoneDataStatus];
}
