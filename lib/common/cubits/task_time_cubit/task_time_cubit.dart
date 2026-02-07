import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_mate/common/cubits/task_time_cubit/task_time_data_status.dart';
import 'package:task_mate/common/utils/services/date_manager.dart';
import 'package:task_mate/features/feature_home/data/models/persian_date.dart';
import 'package:task_mate/features/feature_home/data/repository/task_repository.dart';

part 'task_time_state.dart';

class TaskTimeCubit extends Cubit<TaskTimeState> {
  final ITaskRepository taskRepository;
  TaskTimeCubit(this.taskRepository)
      : super(TaskTimeState(
            taskTimeDataStatus: TaskTimeDataLoading(),
            date: PersianDate.fromJalali(DateManager.dates.first),
            isStartupComplete: false));

  Future<void> getTaskTimeData(PersianDate date) async {
    emit(state.copyWith(newTaskTimeDataStatus: TaskTimeDataLoading()));

    final startTimeList = await taskRepository.getTaskStartTimeList(date);
    final endTimeList = await taskRepository.getTaskEndTimeList(date);

    startTimeList.fold((error) {
      emit(state.copyWith(
          newTaskTimeDataStatus: TaskTimeDataError(message: error)));
    }, (startTimeList) {
      endTimeList.fold((error) {
        emit(state.copyWith(
            newTaskTimeDataStatus: TaskTimeDataError(message: error)));
      }, (endTimeList) {
        emit(state.copyWith(
            newTaskTimeDataStatus: TaskTimeDataLoaded(
                startTimeOfDayList: startTimeList,
                endTimeOfDayList: endTimeList),
            newDate: date,
            newIsStartupComplete: true));
      });
    });
  }
}
