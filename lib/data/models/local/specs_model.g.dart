// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specs_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpecsModelAdapter extends TypeAdapter<SpecsModel> {
  @override
  final int typeId = 2;

  @override
  SpecsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpecsModel(
      listTeachers: (fields[0] as List).cast<String>(),
      list1Course: (fields[1] as List).cast<String>(),
      list2Course: (fields[2] as List).cast<String>(),
      list3Course: (fields[3] as List).cast<String>(),
      list4Course: (fields[4] as List).cast<String>(),
      list5Course: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SpecsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.listTeachers)
      ..writeByte(1)
      ..write(obj.list1Course)
      ..writeByte(2)
      ..write(obj.list2Course)
      ..writeByte(3)
      ..write(obj.list3Course)
      ..writeByte(4)
      ..write(obj.list4Course)
      ..writeByte(5)
      ..write(obj.list5Course);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
