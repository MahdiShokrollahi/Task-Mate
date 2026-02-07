import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_mate/features/feature_home/data/models/my_time_of_day.dart';
import 'package:task_mate/features/feature_home/data/models/persian_date.dart';
import 'package:task_mate/features/feature_home/data/models/task.dart';
import 'package:task_mate/features/feature_home/data/repository/task_repository.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_done_data_status.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_un_done_data_status.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final ITaskRepository taskRepository;
  TaskCubit(this.taskRepository)
      : super(TaskState(
            percentCompleted: 0,
            taskDoneDataStatus: TaskDoneDataLoading(),
            taskUndoneDataStatus: TaskUnDoneDataLoading()));

  Future<void> getAllUnDoneTask({String searchTerm = ''}) async {
    emit(state.copyWith(newTaskUndoneDataStatus: TaskUnDoneDataLoading()));
    var result = await taskRepository.getAll(searchKeyword: searchTerm);
    result.fold((error) {
      emit(state.copyWith(
          newTaskUndoneDataStatus: TaskUnDoneDataFailed(error: error)));
    }, (taskList) {
      if (taskList.isNotEmpty) {
        final unDoneTaskList =
            taskList.where((element) => element.isDone == false).toList();
        if (unDoneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskUndoneDataStatus:
                  TaskUnDoneDataCompleted(unDoneTaskList: unDoneTaskList)));
        } else {
          emit(state.copyWith(newTaskUndoneDataStatus: TasksUnDoneDataEmpty()));
        }
      } else {
        emit(state.copyWith(newTaskUndoneDataStatus: TasksUnDoneDataEmpty()));
      }
    });
  }

  Future<void> getAllDoneTask() async {
    emit(state.copyWith(newTaskDoneDataStatus: TaskDoneDataLoading()));
    var result = await taskRepository.getAll();
    result.fold((error) {
      emit(state.copyWith(
          newTaskDoneDataStatus: TaskDoneDataFailed(error: error)));
    }, (taskList) {
      if (taskList.isNotEmpty) {
        final doneTaskList =
            taskList.where((element) => element.isDone == true).toList();
        if (doneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskDoneDataStatus:
                  TaskDoneDataCompleted(doneTaskList: doneTaskList)));
        } else {
          emit(state.copyWith(newTaskDoneDataStatus: TasksDoneDataEmpty()));
        }
      } else {
        emit(state.copyWith(newTaskDoneDataStatus: TasksDoneDataEmpty()));
      }
    });
  }

  Future<void> getTaskByCategoryId(int id) async {
    emit(state.copyWith(newTaskUndoneDataStatus: TaskUnDoneDataLoading()));
    var result = await taskRepository.getTaskByCategoryId(id);
    result.fold((error) {
      emit(state.copyWith(
          newTaskUndoneDataStatus: TaskUnDoneDataFailed(error: error)));
    }, (taskList) {
      if (taskList.isNotEmpty) {
        final unDoneTaskList =
            taskList.where((element) => element.isDone == false).toList();
        if (unDoneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskUndoneDataStatus:
                  TaskUnDoneDataCompleted(unDoneTaskList: unDoneTaskList)));
        } else {
          emit(state.copyWith(newTaskUndoneDataStatus: TasksUnDoneDataEmpty()));
        }
      } else {
        emit(state.copyWith(newTaskUndoneDataStatus: TasksUnDoneDataEmpty()));
      }
    });
  }

  Future<void> createOrUpdateTask(TaskModel task, PersianDate date) async {
    emit(state.copyWith(newTaskUndoneDataStatus: TaskUnDoneDataLoading()));
    var result = await taskRepository.createOrUpdate(task, date);
    result.fold((error) {
      emit(state.copyWith(
          newTaskUndoneDataStatus: TaskUnDoneDataFailed(error: error)));
    }, (taskList) {
      if (taskList.isNotEmpty) {
        final unDoneTaskList =
            taskList.where((element) => element.isDone == false).toList();
        final doneTaskList =
            taskList.where((element) => element.isDone == true).toList();
        state.percentCompleted =
            doneTaskList.length / (doneTaskList.length + unDoneTaskList.length);
        if (unDoneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskUndoneDataStatus:
                  TaskUnDoneDataCompleted(unDoneTaskList: unDoneTaskList)));
        } else {
          emit(state.copyWith(newTaskUndoneDataStatus: TasksUnDoneDataEmpty()));
        }
      } else {
        emit(state.copyWith(newTaskUndoneDataStatus: TasksUnDoneDataEmpty()));
      }
    });
  }

  // Future<void> deleteAll() async {
  //   emit(state.copyWith(newTaskDataStatus: TaskDataLoading()));
  //   var result = await taskRepository.deleteAll();
  //   result.fold((error) {
  //     emit(state.copyWith(newTaskDataStatus: TaskDataFailed(error: error)));
  //   }, (message) {
  //     emit(state.copyWith(newTaskDataStatus: TasksUnDoneDataEmpty()));
  //   });
  // }

  Future<void> deleteTask(TaskModel taskModel, PersianDate date) async {
    emit(state.copyWith(newTaskUndoneDataStatus: TaskUnDoneDataLoading()));
    var result = await taskRepository.delete(taskModel, date);
    result.fold((error) {
      emit(state.copyWith(
          newTaskUndoneDataStatus: TaskUnDoneDataFailed(error: error)));
    }, (taskList) {
      if (taskList.isNotEmpty) {
        final unDoneTaskList =
            taskList.where((element) => element.isDone == false).toList();
        final doneTaskList =
            taskList.where((element) => element.isDone == true).toList();
        state.percentCompleted =
            doneTaskList.length / (doneTaskList.length + unDoneTaskList.length);
        if (unDoneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskUndoneDataStatus:
                  TaskUnDoneDataCompleted(unDoneTaskList: unDoneTaskList)));
        } else {
          emit(state.copyWith(newTaskUndoneDataStatus: TasksUnDoneDataEmpty()));
        }
      } else {
        emit(state.copyWith(newTaskUndoneDataStatus: TasksUnDoneDataEmpty()));
      }
    });
  }

  Future<void> taskChecker(TaskModel taskModel, PersianDate date) async {
    emit(state.copyWith(
        newTaskDoneDataStatus: TaskDoneDataLoading(),
        newTaskUndoneDataStatus: TaskUnDoneDataLoading()));
    var result = await taskRepository.taskChecker(taskModel, date);
    result.fold((error) {
      emit(state.copyWith(
          newTaskDoneDataStatus: TaskDoneDataFailed(error: error),
          newTaskUndoneDataStatus: TaskUnDoneDataFailed(error: error)));
    }, (taskList) {
      if (taskList.isNotEmpty) {
        final unDoneTaskList =
            taskList.where((element) => element.isDone == false).toList();
        final doneTaskList =
            taskList.where((element) => element.isDone == true).toList();
        state.percentCompleted =
            doneTaskList.length / (doneTaskList.length + unDoneTaskList.length);
        if (unDoneTaskList.isNotEmpty && doneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskUndoneDataStatus:
                  TaskUnDoneDataCompleted(unDoneTaskList: unDoneTaskList),
              newTaskDoneDataStatus:
                  TaskDoneDataCompleted(doneTaskList: doneTaskList)));
        } else if (unDoneTaskList.isEmpty && doneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskUndoneDataStatus: TasksUnDoneDataEmpty(),
              newTaskDoneDataStatus:
                  TaskDoneDataCompleted(doneTaskList: doneTaskList)));
        } else if (doneTaskList.isEmpty && unDoneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskDoneDataStatus: TasksDoneDataEmpty(),
              newTaskUndoneDataStatus:
                  TaskUnDoneDataCompleted(unDoneTaskList: unDoneTaskList)));
        }
      } else {
        emit(state.copyWith(
            newTaskUndoneDataStatus: TasksUnDoneDataEmpty(),
            newTaskDoneDataStatus: TasksDoneDataEmpty()));
      }
    });
  }

  Future<void> filterTask(
      {required PersianDate date,
      MyTimeOfDay? startTime,
      MyTimeOfDay? endTime}) async {
    emit(state.copyWith(
        newTaskDoneDataStatus: TaskDoneDataLoading(),
        newTaskUndoneDataStatus: TaskUnDoneDataLoading()));
    var result = await taskRepository.filterTasks(
        date: date, startTime: startTime, endTime: endTime);
    result.fold((error) {
      emit(state.copyWith(
          newTaskUndoneDataStatus: TaskUnDoneDataFailed(error: error)));
    }, (taskList) {
      if (taskList.isNotEmpty) {
        final unDoneTaskList =
            taskList.where((element) => element.isDone == false).toList();
        final doneTaskList =
            taskList.where((element) => element.isDone == true).toList();
        state.percentCompleted =
            doneTaskList.length / (doneTaskList.length + unDoneTaskList.length);
        if (unDoneTaskList.isNotEmpty && doneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskUndoneDataStatus:
                  TaskUnDoneDataCompleted(unDoneTaskList: unDoneTaskList),
              newTaskDoneDataStatus:
                  TaskDoneDataCompleted(doneTaskList: doneTaskList)));
        } else if (unDoneTaskList.isEmpty && doneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskUndoneDataStatus: TasksUnDoneDataEmpty(),
              newTaskDoneDataStatus:
                  TaskDoneDataCompleted(doneTaskList: doneTaskList)));
        } else if (doneTaskList.isEmpty && unDoneTaskList.isNotEmpty) {
          emit(state.copyWith(
              newTaskDoneDataStatus: TasksDoneDataEmpty(),
              newTaskUndoneDataStatus:
                  TaskUnDoneDataCompleted(unDoneTaskList: unDoneTaskList)));
        }
      } else {
        emit(state.copyWith(
            newTaskUndoneDataStatus: TasksUnDoneDataEmpty(),
            newTaskDoneDataStatus: TasksDoneDataEmpty()));
      }
    });
  }
}
