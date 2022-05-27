import 'package:dartz/dartz.dart';
import 'package:rozklad_knu_fit/domain/entities/calendar_entity.dart';
import 'package:rozklad_knu_fit/domain/entities/info_entity.dart';
import 'package:rozklad_knu_fit/domain/entities/specs_entity.dart';
import '../../internal/error/failure.dart';

abstract class Repository {
  Future<Either<Failure, SpecsEntity>> getSpecs();
  Future<Either<Failure, InfoEntity>> getInfo();
  Future<Either<Failure, CalendarEntity>> getCalendar(Map<String, String> map);
}