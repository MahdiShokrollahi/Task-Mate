import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/common/cubits/bottom_navigation_cubit/bottom_navigation_cubit.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/common/widgets/setting_screen.dart';
import 'package:task_mate/config/routes/app_routes.dart';
import 'package:task_mate/config/routes/edit_task_screen_argument.dart';
import 'package:task_mate/features/feature_home/presentation/screens/home_screen.dart';
import 'package:task_mate/features/feature_task_calendar/presentation/screens/task_calendar_screen.dart';
import 'package:task_mate/features/feature_task_count_down_timer/presentation/screens/task_count_down_timer_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isFabVisible = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              floatingActionButton: state == 0 || state == 1
                  ? Visibility(
                      visible: isFabVisible,
                      child: SizedBox(
                        height: 56,
                        width: 56,
                        child: FloatingActionButton.extended(
                            backgroundColor: AppColors.primaryColor,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.taskEditorScreen,
                                  arguments:
                                      EditTaskScreenArgument(task: null));
                            },
                            label: Image.asset(
                              'assets/images/plus.png',
                              width: 16.w,
                              height: 16.h,
                            )),
                      ),
                    )
                  : null,
              bottomNavigationBar: Container(
                height: 83,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1), blurRadius: 20)
                ]),
                child: BottomNavigationBar(
                    currentIndex: state,
                    onTap: (index) {
                      context.read<BottomNavigationCubit>().changeIndex(index);
                    },
                    backgroundColor: AppColors.surfaceColor,
                    selectedItemColor: AppColors.primaryColor,
                    unselectedItemColor: AppColors.secondaryTextColor,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/home.png',
                          width: 25.w,
                          height: 25.h,
                        ),
                        activeIcon: Image.asset(
                          'assets/images/selected_home.png',
                          width: 25.w,
                          height: 25.h,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/images/calendars.png',
                              width: 25.w, height: 25.h),
                          activeIcon: Image.asset(
                              'assets/images/selected_calendar.png',
                              width: 25.w,
                              height: 25.h),
                          label: 'Calendar'),
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/images/times.png',
                              width: 25.w, height: 25.h),
                          activeIcon: Image.asset(
                              'assets/images/selected_time.png',
                              width: 25.w,
                              height: 25.h),
                          label: 'Time'),
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/images/setting.png',
                              width: 25.w, height: 25.h),
                          activeIcon: Image.asset('assets/images/setting.png',
                              width: 25.w, height: 25.h),
                          label: 'Setting'),
                    ]),
              ),
              body: IndexedStack(
                index: state,
                children: [
                  NotificationListener<UserScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification.direction ==
                            ScrollDirection.forward) {
                          setState(() {
                            isFabVisible = true;
                          });
                        }
                        if (scrollNotification.direction ==
                            ScrollDirection.reverse) {
                          setState(() {
                            isFabVisible = false;
                          });
                        }
                        return true;
                      },
                      child: const HomeScreen()),
                  NotificationListener<UserScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification.direction ==
                            ScrollDirection.forward) {
                          setState(() {
                            isFabVisible = true;
                          });
                        }
                        if (scrollNotification.direction ==
                            ScrollDirection.reverse) {
                          setState(() {
                            isFabVisible = false;
                          });
                        }
                        return true;
                      },
                      child: const TaskCalendarScreen()),
                  const TaskCountDownTimerScreen(),
                  const SettingScreen()
                ],
              ));
        },
      ),
    );
  }
}
