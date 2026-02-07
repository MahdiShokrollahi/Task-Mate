import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/common/utils/constants/app_colors.dart';
import 'package:task_mate/features/feature_home/presentation/widgets/custom_track_shape.dart';

ThemeData appTheme() => ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    sliderTheme: SliderThemeData(
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
      trackShape: CustomTrackShape(),
    ),
    textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: 'SB', fontSize: 12.sp),
        bodyMedium: TextStyle(
          fontFamily: 'SM',
          fontSize: 14.sp,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'SB',
          fontSize: 16.sp,
        ),
        titleLarge: TextStyle(fontSize: 18.sp, fontFamily: 'SB'),
        headlineSmall: TextStyle(fontSize: 24.sp, fontFamily: 'SB'),
        headlineMedium: TextStyle(
          fontSize: 28.sp,
        ),
        headlineLarge: TextStyle(
          fontSize: 38.sp,
        )));
