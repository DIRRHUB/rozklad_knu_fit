// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_calendar_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SingleCalendarObjectAdapter extends TypeAdapter<SingleCalendarObject> {
  @override
  final int typeId = 3;

  @override
  SingleCalendarObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SingleCalendarObject(
      title: fields[0] as String,
      teacher: fields[1] as String,
      time: fields[2] as String,
      online: fields[3] as bool,
      start: fields[4] as num,
      end: fields[5] as num,
      backgroundColor: fields[6] as String,
      type: fields[7] as String,
      url: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SingleCalendarObject obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.teacher)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.online)
      ..writeByte(4)
      ..write(obj.start)
      ..writeByte(5)
      ..write(obj.end)
      ..writeByte(6)
      ..write(obj.backgroundColor)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SingleCalendarObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
