import 'package:rozklad_knu_fit/domain/entities/specs_entity.dart';
import 'package:rozklad_knu_fit/domain/entities/info_entity.dart';
import 'package:rozklad_knu_fit/domain/entities/calendar_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:rozklad_knu_fit/domain/repositories/repository.dart';
import 'package:rozklad_knu_fit/internal/error/failure.dart';

import '../datasources/local/local_datasource.dart';
import '../datasources/remote/remote_datasourse.dart';

class RepositoryImplementation extends Repository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  RepositoryImplementation(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, CalendarEntity>> getCalendar(
      Map<String, String> map) async {
    if (await localDataSource.isEmpty()) {
      var response = await remoteDataSource.getCalendar(map);
      response.fold(
        (l) => null,
        (r) => localDataSource.writeCalendar(r),
      );
      return response;
    } else {
      return await localDataSource.getCalendar(map);
    }
  }

  @override
  Future<Either<Failure, InfoEntity>> getInfo() async {
    if (await localDataSource.isEmpty()) {
      var response = await remoteDataSource.getInfo();
      response.fold(
        (l) => null,
        (r) => localDataSource.writeInfo(r),
      );
      return response;
    } else {
      return await localDataSource.getInfo();
    }
  }

  @override
  Future<Either<Failure, SpecsEntity>> getSpecs() async {
    if (await localDataSource.isEmpty()) {
      var response = await remoteDataSource.getSpecs();
      response.fold(
        (l) => null,
        (r) => localDataSource.writeSpecs(r),
      );
      return response;
    } else {
      return await localDataSource.getSpecs();
    }
  }
}
