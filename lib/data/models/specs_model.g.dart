// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'specs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecsModel _$SpecsModelFromJson(Map<String, dynamic> json) => SpecsModel(
      listTeachers:
          (json['teachers'] as List<dynamic>).map((e) => e as String).toList(),
      list1Course:
          (json['1 курс'] as List<dynamic>).map((e) => e as String).toList(),
      list2Course:
          (json['2 курс'] as List<dynamic>).map((e) => e as String).toList(),
      list3Course:
          (json['3 курс'] as List<dynamic>).map((e) => e as String).toList(),
      list4Course:
          (json['4 курс'] as List<dynamic>).map((e) => e as String).toList(),
      list5Course: (json['1 курс ОС магістр'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SpecsModelToJson(SpecsModel instance) =>
    <String, dynamic>{
      'teachers': instance.listTeachers,
      '1 курс': instance.list1Course,
      '2 курс': instance.list2Course,
      '3 курс': instance.list3Course,
      '4 курс': instance.list4Course,
      '1 курс ОС магістр': instance.list5Course,
    };
