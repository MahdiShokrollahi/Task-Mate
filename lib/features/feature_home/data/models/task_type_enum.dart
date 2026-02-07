import 'package:hive/hive.dart';
part 'task_type_enum.g.dart';

@HiveType(typeId: 1)
enum TaskTypeEnum {
  @HiveField(0)
  sport,
  @HiveField(1)
  education,
  @HiveField(2)
  workout,
  @HiveField(3)
  buy,
  @HiveField(4)
  focus,
  @HiveField(5)
  meeting,
}
