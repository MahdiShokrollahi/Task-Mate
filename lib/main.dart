import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_mate/common/utils/constants/constants.dart';
import 'package:task_mate/common/utils/services/notification_service.dart';
import 'package:task_mate/common/widgets/main_screen.dart';
import 'package:task_mate/config/routes/app_routes.dart';
import 'package:task_mate/config/theme/app_theme.dart';
import 'package:task_mate/features/feature_home/data/models/my_time_of_day.dart';
import 'package:task_mate/features/feature_home/data/models/persian_date.dart';
import 'package:task_mate/features/feature_home/data/models/task.dart';
import 'package:task_mate/features/feature_home/data/models/task_type.dart';
import 'package:task_mate/features/feature_home/data/models/task_type_enum.dart';
import 'package:task_mate/locator.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(MyTimeOfDayAdapter());
  Hive.registerAdapter(PersianDateAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  await Hive.openBox<TaskModel>(Constants.taskBox);
  setUpServiceLocator();
  final notificationService = locator<NotificationService>();
  await notificationService.initializePlatformNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: '/',
        home: const Directionality(
            textDirection: TextDirection.rtl, child: MainScreen()),
      ),
    );
  }
}
