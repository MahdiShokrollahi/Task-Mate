import 'package:dartz/dartz.dart';
import 'package:task_mate/features/feature_home/data/data_source/local/local_task_data_source.dart';
import 'package:task_mate/features/feature_home/data/models/my_time_of_day.dart';
import 'package:task_mate/features/feature_home/data/models/persian_date.dart';
import 'package:task_mate/features/feature_home/data/models/task.dart';

abstract class ITaskRepository {
  Future<Either<String, List<TaskModel>>> getAll({String searchKeyword = ''});
  Future<Either<String, TaskModel>> findById(dynamic id);
  Future<Either<String, List<TaskModel>>> filterTasks(
      {required PersianDate date,
      MyTimeOfDay? startTime,
      MyTimeOfDay? endTime});
  Future<Either<String, String>> deleteAll();
  Future<Either<String, List<TaskModel>>> delete(
      TaskModel data, PersianDate date);
  Future<Either<String, List<TaskModel>>> deleteById(dynamic id);
  Future<Either<String, List<TaskModel>>> getTaskByCategoryId(int sortId);
  Future<Either<String, List<TaskModel>>> createOrUpdate(
      TaskModel data, PersianDate date);
  Future<Either<String, List<MyTimeOfDay>>> getTaskStartTimeList(
      PersianDate date);
  Future<Either<String, List<MyTimeOfDay>>> getTaskEndTimeList(
      PersianDate date);
  Future<Either<String, List<TaskModel>>> taskChecker(
      TaskModel task, PersianDate date);
}

class TaskRepository implements ITaskRepository {
  final ILocalTaskDataSource taskDataSource;

  TaskRepository({required this.taskDataSource});
  @override
  Future<Either<String, List<TaskModel>>> createOrUpdate(
      TaskModel data, PersianDate date) async {
    try {
      await taskDataSource.createOrUpdate(data);
      final taskList = await taskDataSource.filterTasks(date: date);
      return right(taskList);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> delete(
      TaskModel data, PersianDate date) async {
    try {
      await taskDataSource.delete(data);
      final taskList = await taskDataSource.filterTasks(date: date);
      return right(taskList);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteAll() async {
    try {
      await taskDataSource.deleteAll();
      return right('تمامی تسک ها با موفقیت حذف شد');
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> deleteById(id) async {
    try {
      await taskDataSource.deleteById(id);
      final taskList = await taskDataSource.getAll();
      return right(taskList);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, TaskModel>> findById(id) async {
    try {
      final task = await taskDataSource.findById(id);
      return right(task);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getAll(
      {String searchKeyword = ''}) async {
    try {
      final taskList =
          await taskDataSource.getAll(searchKeyword: searchKeyword);
      return right(taskList);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getTaskByCategoryId(
      int sortId) async {
    try {
      final taskList = await taskDataSource.getTaskByCategoryId(sortId);
      return right(taskList);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MyTimeOfDay>>> getTaskStartTimeList(
      PersianDate date) async {
    try {
      final startTimeList = await taskDataSource.getTaskStartTimeList(date);
      return right(startTimeList);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> taskChecker(
      TaskModel task, PersianDate date) async {
    try {
      await taskDataSource.taskChecker(task);
      final taskList = await taskDataSource.filterTasks(date: date);
      return right(taskList);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> filterTasks(
      {required PersianDate date,
      MyTimeOfDay? startTime,
      MyTimeOfDay? endTime}) async {
    try {
      final taskList = await taskDataSource.filterTasks(
          date: date, startTime: startTime, endTime: endTime);
      return right(taskList);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MyTimeOfDay>>> getTaskEndTimeList(
      PersianDate date) async {
    try {
      final endTimeList = await taskDataSource.getTaskEndTimeList(date);
      return right(endTimeList);
    } catch (e) {
      return left(e.toString());
    }
  }
}
