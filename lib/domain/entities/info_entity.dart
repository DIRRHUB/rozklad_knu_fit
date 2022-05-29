import 'package:equatable/equatable.dart';

class InfoEntity extends Equatable {
  final num date;
  final List<String> listTeachers;

  const InfoEntity({
    required this.date,
    required this.listTeachers,
  });

/*
  factory InfoEntity.fromMap(Map<String, dynamic> map) {
    return InfoEntity(
      date: map['date'] as num,
      listTeachers: map['teachers'] as List<String>,
    );
  }
  */

  @override
  List<Object?> get props => [date, listTeachers];
}
