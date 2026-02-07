import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateManager {
  static final List<Jalali> dates = List<Jalali>.generate(10, (index) {
    return Jalali.now().addDays(index);
  });

  static final List<String> weekdays = [
    'جمعه',
    'شنبه',
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنج‌شنبه'
  ];
  static final List<String> months = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];
}
