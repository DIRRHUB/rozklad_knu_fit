import 'package:equatable/equatable.dart';

class InfoEntity extends Equatable {
  final num date;
  final List<String> listTeachers;

  const InfoEntity({
    required this.date,
    required this.listTeachers,
  });

  @override
  List<Object?> get props => [date, listTeachers];
}
