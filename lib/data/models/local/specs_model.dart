import 'package:hive/hive.dart';

part 'specs_model.g.dart';

@HiveType(typeId: 2)
class SpecsModel extends HiveObject {
  @HiveField(0)
  final List<String> listTeachers;
  @HiveField(1)
  final List<String> list1Course;
  @HiveField(2)
  final List<String> list2Course;
  @HiveField(3)
  final List<String> list3Course;
  @HiveField(4)
  final List<String> list4Course;
  @HiveField(5)
  final List<String> list5Course;

  SpecsModel(
      {required this.listTeachers,
      required this.list1Course,
      required this.list2Course,
      required this.list3Course,
      required this.list4Course,
      required this.list5Course});
}
