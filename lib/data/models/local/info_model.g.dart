// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InfoModelAdapter extends TypeAdapter<InfoModel> {
  @override
  final int typeId = 1;

  @override
  InfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InfoModel(
      date: fields[0] as num,
      listTeachers: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, InfoModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.listTeachers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
