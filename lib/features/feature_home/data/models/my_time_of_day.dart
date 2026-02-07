// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'my_time_of_day.g.dart';

@HiveType(typeId: 2)
class MyTimeOfDay {
  @HiveField(0)
  int? hour;
  @HiveField(1)
  int? minute;
  MyTimeOfDay({
    required this.hour,
    required this.minute,
  });

  static MyTimeOfDay fromTimeOfDay(TimeOfDay time) {
    return MyTimeOfDay(hour: time.hour, minute: time.minute);
  }

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour!, minute: minute!);
  }
}
