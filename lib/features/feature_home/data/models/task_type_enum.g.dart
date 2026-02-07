// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeEnumAdapter extends TypeAdapter<TaskTypeEnum> {
  @override
  final int typeId = 1;

  @override
  TaskTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskTypeEnum.sport;
      case 1:
        return TaskTypeEnum.education;
      case 2:
        return TaskTypeEnum.workout;
      case 3:
        return TaskTypeEnum.buy;
      case 4:
        return TaskTypeEnum.focus;
      case 5:
        return TaskTypeEnum.meeting;
      default:
        return TaskTypeEnum.sport;
    }
  }

  @override
  void write(BinaryWriter writer, TaskTypeEnum obj) {
    switch (obj) {
      case TaskTypeEnum.sport:
        writer.writeByte(0);
        break;
      case TaskTypeEnum.education:
        writer.writeByte(1);
        break;
      case TaskTypeEnum.workout:
        writer.writeByte(2);
        break;
      case TaskTypeEnum.buy:
        writer.writeByte(3);
        break;
      case TaskTypeEnum.focus:
        writer.writeByte(4);
        break;
      case TaskTypeEnum.meeting:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
