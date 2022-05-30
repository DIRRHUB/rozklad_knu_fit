import 'package:json_annotation/json_annotation.dart';

part 'info_model.g.dart';

@JsonSerializable()
class InfoModel {
  @JsonKey(name: 'date')
  final num date;
  @JsonKey(name: 'teachers')
  final List<String> listTeachers;

  const InfoModel({required this.date, required this.listTeachers});

  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);
}
