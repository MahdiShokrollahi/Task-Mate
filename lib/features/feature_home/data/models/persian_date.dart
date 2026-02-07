// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
part 'persian_date.g.dart';

@HiveType(typeId: 4)
class PersianDate {
  @HiveField(0)
  int? year;
  @HiveField(1)
  int? month;
  @HiveField(2)
  int? day;
  PersianDate({
    required this.year,
    required this.month,
    required this.day,
  });

  static PersianDate fromJalali(Jalali date) {
    return PersianDate(year: date.year, month: date.month, day: date.day);
  }

  Jalali toJalali() {
    return Jalali(year!, month!, day!);
  }
}
