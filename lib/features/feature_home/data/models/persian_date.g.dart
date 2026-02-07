// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persian_date.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersianDateAdapter extends TypeAdapter<PersianDate> {
  @override
  final int typeId = 4;

  @override
  PersianDate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersianDate(
      year: fields[0] as int?,
      month: fields[1] as int?,
      day: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PersianDate obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.month)
      ..writeByte(2)
      ..write(obj.day);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersianDateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
