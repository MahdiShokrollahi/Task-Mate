import 'package:hive/hive.dart';
import 'package:task_mate/features/feature_home/data/models/my_time_of_day.dart';
import 'package:task_mate/features/feature_home/data/models/persian_date.dart';
import 'package:task_mate/features/feature_home/data/models/task.dart';

abstract class ILocalTaskDataSource {
  Future<List<TaskModel>> getAll({String searchKeyword = ''});
  Future<List<TaskModel>> filterTasks(
      {required PersianDate date,
      MyTimeOfDay? startTime,
      MyTimeOfDay? endTime});
  Future<TaskModel> findById(dynamic id);
  Future<void> deleteAll();
  Future<void> delete(TaskModel data);
  Future<void> deleteById(int id);
  Future<List<TaskModel>> getTaskByCategoryId(int sortId);
  Future<TaskModel> createOrUpdate(TaskModel data);
  Future<List<MyTimeOfDay>> getTaskStartTimeList(PersianDate date);
  Future<List<MyTimeOfDay>> getTaskEndTimeList(PersianDate date);
  Future<void> taskChecker(TaskModel task);
}

class LocalTaskDataSource implements ILocalTaskDataSource {
  final Box<TaskModel> box;

  LocalTaskDataSource({required this.box});
  @override
  Future<TaskModel> createOrUpdate(TaskModel data) async {
    if (data.isInBox) {
      data.save();
    } else {
      box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(TaskModel data) async {
    data.delete();
  }

  @override
  Future<void> deleteAll() async {
    box.clear();
  }

  @override
  Future<void> deleteById(id) async {
    box.delete(id);
  }

  @override
  Future<TaskModel> findById(id) async {
    return box.values.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<TaskModel>> getAll({String searchKeyword = ''}) async {
    if (searchKeyword.isNotEmpty) {
      return box.values
          .where((element) => element.title.contains(searchKeyword))
          .toList();
    } else {
      return box.values.toList();
    }
  }

  @override
  Future<List<TaskModel>> getTaskByCategoryId(int sortId) async {
    return box.values
        .where((element) => element.taskType.sortId == sortId)
        .toList();
  }

  @override
  Future<List<MyTimeOfDay>> getTaskStartTimeList(PersianDate date) async {
    final startTimeList = box.values
        .where((element) =>
            element.isDone == false &&
            element.date.day == date.day &&
            element.date.month == date.month &&
            element.date.year == date.year)
        .map((e) => e.startTime)
        .toList();
    return startTimeList;
  }

  @override
  Future<void> taskChecker(TaskModel task) async {
    task.isDone = !task.isDone;
    task.save();
  }

  @override
  Future<List<TaskModel>> filterTasks(
      {required PersianDate date,
      MyTimeOfDay? startTime,
      MyTimeOfDay? endTime}) async {
    if (startTime != null && endTime != null) {
      return box.values
          .where((element) =>
              element.date.day == date.day &&
              element.date.month == date.month &&
              element.date.year == date.year &&
              element.startTime.hour! >= startTime.hour! &&
              element.startTime.minute! >= startTime.minute! &&
              element.endTime.hour! <= endTime.hour! &&
              element.endTime.minute! <= endTime.minute!)
          .toList();
    } else {
      return box.values
          .where((element) =>
              element.date.day == date.day &&
              element.date.month == date.month &&
              element.date.year == date.year)
          .toList();
    }
  }

  @override
  Future<List<MyTimeOfDay>> getTaskEndTimeList(PersianDate date) async {
    final endTimeList = box.values
        .where((element) =>
            element.isDone == false &&
            element.date.day == date.day &&
            element.date.month == date.month &&
            element.date.year == date.year)
        .map((e) => e.endTime)
        .toList();
    return endTimeList;
  }
}
