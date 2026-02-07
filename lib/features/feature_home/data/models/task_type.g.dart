// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeAdapter extends TypeAdapter<TaskType> {
  @override
  final int typeId = 3;

  @override
  TaskType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskType(
      title: fields[1] as String,
      image: fields[3] as String,
      taskTypeEnum: fields[4] as TaskTypeEnum,
      sortId: fields[0] as int,
      categoryImage: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskType obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sortId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.categoryImage)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.taskTypeEnum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
