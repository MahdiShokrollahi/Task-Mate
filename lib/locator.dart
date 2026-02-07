import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_mate/common/cubits/task_time_cubit/task_time_cubit.dart';
import 'package:task_mate/common/utils/constants/constants.dart';
import 'package:task_mate/common/utils/services/notification_service.dart';
import 'package:task_mate/features/feature_home/data/data_source/local/local_task_data_source.dart';
import 'package:task_mate/features/feature_home/data/models/task.dart';
import 'package:task_mate/features/feature_home/data/repository/task_repository.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';

var locator = GetIt.instance;

setUpServiceLocator() {
  //data sources
  final box = Hive.box<TaskModel>(Constants.taskBox);
  locator.registerFactory<ILocalTaskDataSource>(
      () => LocalTaskDataSource(box: box));

  //repositories
  locator.registerFactory<ITaskRepository>(
      () => TaskRepository(taskDataSource: locator()));

  //services
  locator.registerFactory<NotificationService>(() => NotificationService());

  //cubits
  locator.registerSingleton<TaskCubit>(TaskCubit(locator()));
  locator.registerSingleton<TaskTimeCubit>(TaskTimeCubit(locator()));
}
