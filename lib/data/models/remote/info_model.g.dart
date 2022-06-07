// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) => InfoModel(
      date: json['date'] as num,
      listTeachers:
          (json['teachers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$InfoModelToJson(InfoModel instance) => <String, dynamic>{
      'date': instance.date,
      'teachers': instance.listTeachers,
    };
