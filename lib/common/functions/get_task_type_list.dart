import 'package:task_mate/features/feature_home/data/models/task_type.dart';
import 'package:task_mate/features/feature_home/data/models/task_type_enum.dart';

List<TaskType> getTaskTypeList() {
  List<TaskType> list = [
    TaskType(
        title: 'آموزش',
        image: 'education',
        taskTypeEnum: TaskTypeEnum.education,
        sortId: 0,
        categoryImage: 'assets/images/edu.png'),
    TaskType(
        title: 'ورزش',
        image: 'sport',
        taskTypeEnum: TaskTypeEnum.sport,
        sortId: 1,
        categoryImage: 'assets/images/gym.png'),
    TaskType(
        title: 'بانکی',
        image: 'banking',
        taskTypeEnum: TaskTypeEnum.buy,
        sortId: 2,
        categoryImage: 'assets/images/eCommerce.png'),
    TaskType(
        title: 'تمرکز',
        image: 'focus',
        taskTypeEnum: TaskTypeEnum.focus,
        sortId: 3,
        categoryImage: 'assets/images/edu.png'),
    TaskType(
        title: 'جلسه',
        image: 'meeting',
        taskTypeEnum: TaskTypeEnum.meeting,
        sortId: 4,
        categoryImage: 'assets/images/eCommerce.png'),
    TaskType(
        title: 'تمرین',
        image: 'workout',
        taskTypeEnum: TaskTypeEnum.workout,
        sortId: 5,
        categoryImage: 'assets/images/edu.png'),
  ];
  return list;
}
