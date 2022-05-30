import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../domain/entities/calendar_entity.dart';
import '../../../domain/entities/info_entity.dart';
import '../../../domain/entities/specs_entity.dart';
import '../../../internal/error/failure.dart';
import '../../models/remote/calendar_model.dart';
import '../../models/remote/info_model.dart';
import '../../models/remote/specs_model.dart';
import '../datasource.dart';

class RemoteDataSource extends DataSource {
  final String server = "https://ap-rozklad-back.herokuapp.com";
  final String mask = "timetables";
  final String version = "3";

  @override
  Future<Either<Failure, InfoEntity>> getInfo() async {
    Response response;
    var dio = Dio();
    try {
      response = await dio.get('$server/$mask/$version/getInfo');
      if (response.statusCode == 500) throw ServerFailure();
      InfoModel infoModel = InfoModel.fromJson(response.data);
      InfoEntity infoEntity = InfoEntity(
          date: infoModel.date, listTeachers: infoModel.listTeachers);
      return Right(infoEntity);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SpecsEntity>> getSpecs() async {
    Response response;
    var dio = Dio();
    try {
      response = await dio.get('$server/$mask/$version/getSpecs');
      if (response.statusCode == 500) throw ServerFailure();
      SpecsModel specsModel = SpecsModel.fromJson(response.data);
      SpecsEntity specsEntity = SpecsEntity(
        list1Course: specsModel.list1Course,
        list2Course: specsModel.list2Course,
        list3Course: specsModel.list3Course,
        list4Course: specsModel.list4Course,
        list5Course: specsModel.list5Course,
        listTeachers: specsModel.listTeachers,
      );
      return Right(specsEntity);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CalendarEntity>> getCalendar(
      Map<String, String> map) async {
    Response response;
    var dio = Dio();
    try {
      response = await dio.post('$server/$mask/$version/getCal', data: map);
      if (response.statusCode == 200) {
        CalendarModel calendarModel = CalendarModel.fromJson(response.data);
        CalendarEntity calendarEntity =
            CalendarEntity(list: calendarModel.list);
        return Right(calendarEntity);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      if (e.toString().contains("400")) {
        return Left(MissingParametersFailure());
      } else if (e.toString().contains("404")) {
        return Left(NotFoundFailure());
      } else if (e.toString().contains("500")) {
        return Left(ServerFailure());
      } else {
        return Left(UnknownFailure());
      }
    }
  }
}
