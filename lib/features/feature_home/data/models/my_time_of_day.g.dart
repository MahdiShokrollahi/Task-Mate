// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_time_of_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyTimeOfDayAdapter extends TypeAdapter<MyTimeOfDay> {
  @override
  final int typeId = 2;

  @override
  MyTimeOfDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyTimeOfDay(
      hour: fields[0] as int?,
      minute: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MyTimeOfDay obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyTimeOfDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
