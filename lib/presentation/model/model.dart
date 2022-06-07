import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rozklad_knu_fit/data/datasources/local/local_datasource.dart';
import 'package:rozklad_knu_fit/data/datasources/remote/remote_datasourse.dart';
import 'package:rozklad_knu_fit/data/repositories/repository_implementation.dart';
import 'package:rozklad_knu_fit/internal/resources/colors.dart';
import '../../data/models/day_object.dart';
import '../../data/models/single_calendar_object.dart';
import '../../domain/entities/calendar_entity.dart';
import '../../domain/entities/specs_entity.dart';
import '../../internal/error/failure.dart';

class Model {
  final RepositoryImplementation _repositoryImplementation =
      RepositoryImplementation(
          localDataSource: LocalDataSource(),
          remoteDataSource: RemoteDataSource());
  late int _intStartDate;
  late int _intEndDate;
  late int _intMaxDay;
  CalendarEntity? _calendarEntity;

  Future<bool> isEmpty() async {
    return await _repositoryImplementation.localDataSource.isEmpty();
  }

  Future<SpecsEntity?> getSpecs() async {
    Either<Failure, SpecsEntity> response =
        await _repositoryImplementation.getSpecs();
    SpecsEntity? specsEntity;
    response.fold((l) => specsEntity = null, (r) => specsEntity = r);
    return specsEntity;
  }

  Future<Map<int, List<DayObject>>> getMapTable(
      {Map<String, String>? map}) async {
    Either<Failure, CalendarEntity> response;
    if (map == null) {
      response = await _repositoryImplementation.getCalendar();
      response.fold((l) {}, (r) => _calendarEntity = r);
    } else {
      response = await _repositoryImplementation.getCalendar(map: map);
      response.fold(
        (l) => {
          Fluttertoast.showToast(
              msg: "Виникла помилка: $l",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0),
        },
        (r) {
          _calendarEntity = r;
          Fluttertoast.showToast(
              msg: "Збережено",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        },
      );
    }

    List<SingleCalendarObject> list = _calendarEntity?.list ?? [];
    Map<int, List<DayObject>> mapResult = {};
    setCurrentDate();
    for (var element in list) {
      if (element.start >= _intStartDate && element.end <= _intEndDate) {
        Color typeColor;
        String typeLesson;
        if (element.backgroundColor == "blue") {
          typeColor = AppColors.practiceColor;
          typeLesson = "Практика";
        } else {
          typeColor = AppColors.lectureColor;
          typeLesson = "Лекція";
        }
        var date = DateTime.fromMillisecondsSinceEpoch(element.start as int);
        int day = date.day;
        var dayObject = DayObject(
          name: element.title,
          time: element.time,
          date: day,
          colorType: typeColor,
          link: element.url,
          teacher: element.teacher,
          type: typeLesson,
        );
        if (mapResult.containsKey(day)) {
          mapResult[day]!.add(dayObject);
        } else {
          mapResult[day] = [dayObject];
        }
      }
    }
    return mapResult;
  }

  Future<List<List<int>>> getMatrixTable() async {
    List<List<int>> matrix =
        List.generate(6, (i) => List.filled(7, 0), growable: false);

    int x = 0;
    int y = 0;
    _intStartDate;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(_intStartDate);
    int day = date.day;
    switch (date.weekday) {
      case DateTime.monday:
        x = 0;
        matrix[y][x] = day++;
        break;
      case DateTime.tuesday:
        x = 1;
        matrix[y][x++] = day++;
        break;
      case DateTime.wednesday:
        x = 2;
        matrix[y][x++] = day++;
        break;
      case DateTime.thursday:
        x = 3;
        matrix[y][x++] = day++;
        break;
      case DateTime.friday:
        x = 4;
        matrix[y][x++] = day++;
        break;
      case DateTime.saturday:
        x = 5;
        matrix[y][x++] = day++;
        break;
      case DateTime.sunday:
        x = 6;
        matrix[y][x++] = day++;
        y++;
        x = 0;
        break;
    }

    for (int i = x - 1; i <= _intMaxDay; i++) {
      matrix[y][x] = day++;
      if (x == 6) {
        x = 0;
        y++;
      } else {
        x++;
      }
    }
    return matrix;
  }

  Future<List<bool>> isDayExists(
      List<List<int>> matrixTable, Map<int, List<DayObject>> mapTable) async {
    List<bool> daysExistTable = List.filled(31, false);
    List daysList = List.filled(42, 0);
    int index = 0;
    for (var x in matrixTable) {
      for (var y in x) {
        daysList[index++] = y;
      }
    }
    index = 0;
    for (int i = 0; i < daysList.length; i++) {
      if (daysList[i] != 0) {
        if (mapTable.containsKey(daysList[i])) {
          daysExistTable[index] = true;
        } else {
          daysExistTable[index] = false;
        }
        index++;
      }
    }
    return daysExistTable;
  }

  void setCurrentDate() {
    DateTime now = DateTime.now();
    DateTime dateStart = DateTime(now.year, now.month);
    DateTime dateEnd;
    _intStartDate = dateStart.millisecondsSinceEpoch;
    if (now.month != 12) {
      dateEnd = DateTime(now.year, now.month + 1);
    } else {
      dateEnd = DateTime(now.year + 1, 1);
    }
    _intEndDate = dateEnd.millisecondsSinceEpoch;
    _intMaxDay = DateTime(now.year, now.month + 1, 0).day;
  }

  Map<String, String> evaluateCalendarTime() {
    DateTime now = DateTime.now();
    String start, end;
    int currentMonth = now.month;
    if (currentMonth >= 9) {
      start = "${now.year}-09-01T00:00:00+01:00";
      end = "${now.year}-12-31T00:00:00+01:00";
    } else {
      start = "${now.year}-01-01T00:00:00+01:00";
      end = "${now.year}-07-01T00:00:00+01:00";
    }
    return {"start": start, "end": end};
  }
}
