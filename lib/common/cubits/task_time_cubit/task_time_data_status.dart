import 'package:equatable/equatable.dart';
import 'package:task_mate/features/feature_home/data/models/my_time_of_day.dart';

abstract class TaskTimeDataStatus extends Equatable {}

class TaskTimeDataLoading extends TaskTimeDataStatus {
  @override
  List<Object> get props => [];
}

class TaskTimeDataLoaded extends TaskTimeDataStatus {
  final List<MyTimeOfDay> startTimeOfDayList;
  final List<MyTimeOfDay> endTimeOfDayList;

  TaskTimeDataLoaded(
      {required this.endTimeOfDayList, required this.startTimeOfDayList});
  @override
  List<Object> get props => [startTimeOfDayList, endTimeOfDayList];
}

class TaskTimeDataError extends TaskTimeDataStatus {
  final String message;

  TaskTimeDataError({required this.message});
  @override
  List<Object> get props => [message];
}
