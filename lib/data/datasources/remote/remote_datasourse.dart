import 'package:dartz/dartz.dart';

import '../../../domain/entities/calendar_entity.dart';
import '../../../domain/entities/info_entity.dart';
import '../../../domain/entities/specs_entity.dart';
import '../../../internal/error/failure.dart';
import '../datasource.dart';

class RemoteDataSource extends DataSource{
  @override
  Future<Either<Failure, InfoEntity>> getInfo() {
    // TODO: implement getInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SpecsEntity>> getSpecs() {
    // TODO: implement getSpecs
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, CalendarEntity>> getCalendar(Map<String, String> map) {
    // TODO: implement getCalendar
    throw UnimplementedError();
  }
  
}