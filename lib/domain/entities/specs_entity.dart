import 'package:equatable/equatable.dart';

class SpecsEntity extends Equatable {
  final List<String> listTeachers;
  final List<String> list1Course;
  final List<String> list2Course;
  final List<String> list3Course;
  final List<String> list4Course;
  final List<String> list5Course;

  const SpecsEntity({
    this.listTeachers = const [],
    this.list1Course = const [],
    this.list2Course = const [],
    this.list3Course = const [],
    this.list4Course = const [],
    this.list5Course = const [],
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
