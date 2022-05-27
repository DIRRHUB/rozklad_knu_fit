import 'package:dartz/dartz.dart';
import 'package:rozklad_knu_fit/data/datasources/datasource.dart';
import 'package:rozklad_knu_fit/internal/error/failure.dart';
import 'package:rozklad_knu_fit/domain/entities/specs_entity.dart';
import 'package:rozklad_knu_fit/domain/entities/info_entity.dart';
import 'package:rozklad_knu_fit/domain/entities/calendar_entity.dart';

class LocalDataSource extends DataSource{
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
  
  Future<bool> isEmpty() async {
   // TODO: implement check whether local database is empty or not
   return true;
  }
}