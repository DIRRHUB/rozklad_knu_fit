import 'package:json_annotation/json_annotation.dart';

part 'specs_model.g.dart';

@JsonSerializable()
class SpecsModel {
  @JsonKey(name: 'teachers')
  final List<String> listTeachers;
  @JsonKey(name: '1 курс')
  final List<String> list1Course;
  @JsonKey(name: '2 курс')
  final List<String> list2Course;
  @JsonKey(name: '3 курс')
  final List<String> list3Course;
  @JsonKey(name: '4 курс')
  final List<String> list4Course;
  @JsonKey(name: '1 курс ОС магістр')
  final List<String> list5Course;

  factory SpecsModel.fromJson(Map<String, List<String>> json) =>
      _$SpecsModelFromJson(json);

  const SpecsModel(
      {required this.listTeachers,
      required this.list1Course,
      required this.list2Course,
      required this.list3Course,
      required this.list4Course,
      required this.list5Course});
}
