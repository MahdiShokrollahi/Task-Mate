import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mate/common/cubits/task_time_cubit/task_time_cubit.dart';
import 'package:task_mate/config/routes/edit_task_screen_argument.dart';
import 'package:task_mate/config/routes/task_list_screen_argument.dart';
import 'package:task_mate/features/feature_home/presentation/screens/home_screen.dart';
import 'package:task_mate/features/feature_home/presentation/screens/task_list_screen.dart';
import 'package:task_mate/features/feature_home/presentation/task_cubit/task_cubit.dart';
import 'package:task_mate/features/feature_task_calendar/presentation/screens/task_calendar_screen.dart';
import 'package:task_mate/features/feature_task_count_down_timer/presentation/screens/task_count_down_timer_screen.dart';
import 'package:task_mate/features/task_editor_feature/presentation/screens/task_editor_screen.dart';
import 'package:task_mate/locator.dart';

class AppRoutes {
  static const homeScreen = '/home_screen';
  static const taskCalendarScreen = '/task_calendar_screen';
  static const taskCountDownTimerScreen = '/task_count_down_timer_screen';
  static const taskEditorScreen = '/task_editor_screen';
  static const taskListScreen = '/task_list_screen.dart';

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case taskCalendarScreen:
        return MaterialPageRoute(builder: (_) => const TaskCalendarScreen());
      case taskCountDownTimerScreen:
        return MaterialPageRoute(
            builder: (_) => const TaskCountDownTimerScreen());
      case taskEditorScreen:
        final arg = settings.arguments as EditTaskScreenArgument;
        return MaterialPageRoute(
            builder: (_) => Directionality(
                textDirection: TextDirection.rtl,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<TaskCubit>.value(
                      value: locator<TaskCubit>(),
                    ),
                    BlocProvider<TaskTimeCubit>.value(
                      value: locator<TaskTimeCubit>(),
                    ),
                  ],
                  child: TaskEditorScreen(
                    taskModel: arg.task,
                  ),
                )));
      case taskListScreen:
        final arg = settings.arguments as TaskListScreenArgument;
        return MaterialPageRoute(
            builder: (_) => Directionality(
                textDirection: TextDirection.rtl,
                child: BlocProvider(
                    create: (context) => TaskCubit(locator()),
                    child: TaskListScreen(
                      sortId: arg.sortId,
                      searchTerm: arg.searchTerm,
                    ))));
    }
    return undeFindRoute();
  }

  static Route undeFindRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(
                child: Text('undeFindRoute'),
              ),
            ));
  }
}
