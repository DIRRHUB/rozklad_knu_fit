import 'package:dartz/dartz.dart';

import '../../domain/entities/calendar_entity.dart';
import '../../domain/entities/info_entity.dart';
import '../../domain/entities/specs_entity.dart';
import '../../internal/error/failure.dart';

abstract class DataSource {
  Future<Either<Failure, SpecsEntity>> getSpecs();
  Future<Either<Failure, InfoEntity>> getInfo();
  Future<Either<Failure, CalendarEntity>> getCalendar(Map<String, String> map);
}