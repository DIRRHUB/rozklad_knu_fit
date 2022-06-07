import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rozklad_knu_fit/data/datasources/datasource.dart';
import 'package:rozklad_knu_fit/data/models/local/calendar_model.dart';
import 'package:rozklad_knu_fit/data/models/local/specs_model.dart';
import 'package:rozklad_knu_fit/internal/error/failure.dart';
import 'package:rozklad_knu_fit/domain/entities/specs_entity.dart';
import 'package:rozklad_knu_fit/domain/entities/info_entity.dart';
import 'package:rozklad_knu_fit/domain/entities/calendar_entity.dart';
import '../../models/local/info_model.dart';

class LocalDataSource extends DataSource {
  late Box _box;

  @override
  Future<Either<Failure, InfoEntity>> getInfo() async {
    try {
      _box = Hive.box(BoxNames.infoBox);
      InfoModel infoModel = await _box.get(BoxNames.info);
      return Right(InfoEntity(
          date: infoModel.date, listTeachers: infoModel.listTeachers));
    } catch (e) {
      return Left(HiveFailure());
    }
  }

  @override
  Future<Either<Failure, SpecsEntity>> getSpecs() async {
    try {
      _box = Hive.box(BoxNames.specsBox);
      SpecsModel specsModel = await _box.get(BoxNames.specs);
      return Right(SpecsEntity(
          list1Course: specsModel.list1Course,
          list2Course: specsModel.list2Course,
          list3Course: specsModel.list3Course,
          list4Course: specsModel.list4Course,
          list5Course: specsModel.list5Course,
          listTeachers: specsModel.listTeachers));
    } catch (e) {
      return Left(HiveFailure());
    }
  }

  @override
  Future<Either<Failure, CalendarEntity>> getCalendar(
      Map<String, String> map) async {
    try {
      _box = Hive.box(BoxNames.calendarBox);
      CalendarModel calendarModel = await _box.get(BoxNames.calendar);
      return Right(CalendarEntity(list: calendarModel.list));
    } catch (e) {
      return Left(HiveFailure());
    }
  }

  Future<Either<Failure, CalendarEntity>> getSavedCalendar() async {
    return getCalendar({});
  }

  void writeInfo(InfoEntity infoEntity) async {
    InfoModel infoModel =
        InfoModel(date: infoEntity.date, listTeachers: infoEntity.listTeachers);
    _box = Hive.box(BoxNames.infoBox);
    _box.put(BoxNames.info, infoModel);
  }

  void writeSpecs(SpecsEntity specsEntity) async {
    SpecsModel specsModel = SpecsModel(
        listTeachers: specsEntity.listTeachers,
        list1Course: specsEntity.list1Course,
        list2Course: specsEntity.list2Course,
        list3Course: specsEntity.list3Course,
        list4Course: specsEntity.list4Course,
        list5Course: specsEntity.list5Course);
    _box = Hive.box(BoxNames.specsBox);
    _box.put(BoxNames.specs, specsModel);
  }

  void writeCalendar(CalendarEntity calendarEntity) async {
    CalendarModel calendarModel = CalendarModel(list: calendarEntity.list);
    _box = Hive.box(BoxNames.calendarBox);
    _box.put(BoxNames.calendar, calendarModel);
  }

  Future<bool> isEmpty() async {
    _box = Hive.box(BoxNames.calendarBox);
    if (_box.isEmpty) return true;
    /*_box = Hive.box(BoxNames.infoBox);
    if (_box.isEmpty) return true;*/
    _box = Hive.box(BoxNames.specsBox);
    if (_box.isEmpty) return true;
    return false;
  }
}

abstract class BoxNames {
  static const String infoBox = "info_model_box";
  static const String specsBox = "specs_model_box";
  static const String calendarBox = "calendar_model_box";
  static const String info = "info_model";
  static const String specs = "specs_model";
  static const String calendar = "calendar_model";
}
