import 'package:equatable/equatable.dart';

class SpecsEntity extends Equatable {
  final List<String> listTeachers;
  final List<String> list1Course;
  final List<String> list2Course;
  final List<String> list3Course;
  final List<String> list4Course;
  final List<String> list5Course;

  const SpecsEntity({
    required this.listTeachers,
    required this.list1Course,
    required this.list2Course,
    required this.list3Course,
    required this.list4Course,
    required this.list5Course,
  });

  @override
  List<Object?> get props => [
        listTeachers,
        list1Course,
        list2Course,
        list3Course,
        list4Course,
        list5Course
      ];
}
