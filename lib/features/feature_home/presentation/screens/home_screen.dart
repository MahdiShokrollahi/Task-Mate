import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/features/feature_home/presentation/widgets/header_app_widget.dart';
import 'package:task_mate/features/feature_home/presentation/widgets/list_view_headding.dart';
import 'package:task_mate/features/feature_home/presentation/widgets/search_box_widget.dart';
import 'package:task_mate/common/widgets/task_list_view.dart';
import 'package:task_mate/common/widgets/time_selector_slider.dart';

import '../widgets/category_list_view_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        HeaderAppWidget(themeData: themeData),
        SearchBoxWidget(themeData: themeData),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
            child: ListViewHeading(title: 'دسته بندی', themeData: themeData),
          ),
        ),
        CategoryListViewWidget(themeData: themeData),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
            child:
                ListViewHeading(title: 'تسک های امروز', themeData: themeData),
          ),
        ),
        TimeSelectorSlider(themeData: themeData),
        TaskListView(themeData: themeData)
      ],
    ));
  }
}
