// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_time_cubit.dart';

class TaskTimeState extends Equatable {
  final TaskTimeDataStatus taskTimeDataStatus;
  final PersianDate date;
  final bool isStartupComplete;

  const TaskTimeState({
    required this.taskTimeDataStatus,
    required this.date,
    required this.isStartupComplete,
  });

  @override
  List<Object> get props => [taskTimeDataStatus, date];

  TaskTimeState copyWith(
      {TaskTimeDataStatus? newTaskTimeDataStatus,
      PersianDate? newDate,
      bool? newIsStartupComplete}) {
    return TaskTimeState(
        taskTimeDataStatus: newTaskTimeDataStatus ?? taskTimeDataStatus,
        date: newDate ?? date,
        isStartupComplete: newIsStartupComplete ?? isStartupComplete);
  }
}
