import 'package:hive/hive.dart';
import 'package:task_mate/features/feature_home/data/models/my_time_of_day.dart';
import 'package:task_mate/features/feature_home/data/models/persian_date.dart';
import 'package:task_mate/features/feature_home/data/models/task_type.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  TaskModel(
      {this.id,
      required this.title,
      required this.subTitle,
      this.isDone = false,
      required this.startTime,
      required this.date,
      required this.taskType,
      required this.endTime}) {
    id = DateTime.now().millisecondsSinceEpoch.toInt();
  }
  @HiveField(0)
  int? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subTitle;
  @HiveField(3)
  bool isDone;
  @HiveField(4)
  MyTimeOfDay startTime;
  @HiveField(5)
  MyTimeOfDay endTime;
  @HiveField(6)
  PersianDate date;
  @HiveField(7)
  TaskType taskType;
}
