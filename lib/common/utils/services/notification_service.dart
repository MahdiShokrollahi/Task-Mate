import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/features/feature_home/data/models/task.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  StreamSubscription<DateTime>? streamSubscription;
  Map<int, bool> taskNotificationMap = {};

  Future<void> initializePlatformNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');

    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> startMonitoringTask(List<TaskModel> tasks) async {
    streamSubscription =
        Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now())
            .listen((now) {
      final jalaliNow = Jalali.fromDateTime(now);
      for (var task in tasks) {
        final taskKey = task.id;
        if (!taskNotificationMap.containsKey(taskKey) &&
            task.date.year == jalaliNow.year &&
            task.date.month == jalaliNow.month &&
            task.date.day == jalaliNow.day &&
            task.endTime.hour == now.hour &&
            task.endTime.minute == now.minute) {
          _showNotification(task);
          taskNotificationMap[taskKey!] = true;
        }
      }
    });
  }

  Future<void> _showNotification(TaskModel task) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('1', 'task',
            channelDescription: 'task notification',
            largeIcon: DrawableResourceAndroidBitmap(task.taskType.image),
            actions: [
              const AndroidNotificationAction('delete_action', 'حذف',
                  titleColor: AppColors.primaryColor),
              const AndroidNotificationAction('edit_action', 'ویرایش',
                  titleColor: AppColors.primaryColor)
            ],
            importance: Importance.max,
            priority: Priority.high);

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(1, 'پایان تسک',
        'زمان تسک ${task.title} به پایان رسید.', platformChannelSpecifics,
        payload: task.title);
  }
}
