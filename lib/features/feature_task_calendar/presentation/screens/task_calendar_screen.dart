import 'package:flutter/material.dart';
import 'package:task_mate/common/widgets/time_selector_slider.dart';
import 'package:task_mate/common/widgets/task_list_view.dart';
import 'package:task_mate/features/feature_task_calendar/presentation/widgets/calendar_list_view.dart';
import 'package:task_mate/features/feature_task_calendar/presentation/widgets/task_calendar_header.dart';
import 'package:task_mate/features/feature_task_calendar/presentation/widgets/task_done_list_view.dart';

class TaskCalendarScreen extends StatefulWidget {
  const TaskCalendarScreen({super.key});

  @override
  State<TaskCalendarScreen> createState() => _TaskCalendarScreenState();
}

class _TaskCalendarScreenState extends State<TaskCalendarScreen> {
  bool showTasksDone = true;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        TaskCalendarHeader(themeData: themeData),
        CalendarListView(themeData: themeData),
        TimeSelectorSlider(themeData: themeData),
        TaskListView(themeData: themeData),
        TaskDoneListView(
          themeData: themeData,
        )
      ],
    ));
  }
}
