import 'package:hive/hive.dart';
import 'package:task_mate/features/feature_home/data/models/task_type_enum.dart';
part 'task_type.g.dart';

@HiveType(typeId: 3)
class TaskType {
  TaskType(
      {required this.title,
      required this.image,
      required this.taskTypeEnum,
      required this.sortId,
      required this.categoryImage});
  @HiveField(0)
  int sortId;
  @HiveField(1)
  String title;
  @HiveField(2)
  String categoryImage;
  @HiveField(3)
  String image;
  @HiveField(4)
  TaskTypeEnum taskTypeEnum;
}
