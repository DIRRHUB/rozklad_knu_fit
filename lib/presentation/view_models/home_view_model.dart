// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rozklad_knu_fit/data/datasources/local/local_datasource.dart';
import 'package:rozklad_knu_fit/data/datasources/remote/remote_datasourse.dart';
import 'package:rozklad_knu_fit/data/repositories/repository_implementation.dart';
import 'package:rozklad_knu_fit/internal/resources/colors.dart';

import '../../data/models/day_object.dart';
import '../../data/models/single_calendar_object.dart';
import '../../domain/entities/calendar_entity.dart';
import '../../internal/error/failure.dart';

class HomeViewModel {
  final RepositoryImplementation _repositoryImplementation =
      RepositoryImplementation(
          localDataSource: LocalDataSource(),
          remoteDataSource: RemoteDataSource());
  late var _intStartDate;
  late var _intEndDate;
  late var _intMaxDay;
  CalendarEntity? calendarEntity;

  Future<bool> isEmpty() async {
    return await _repositoryImplementation.localDataSource.isEmpty();
  }

  Future<Map<int, List<DayObject>>> getMapTable(
      {Map<String, String>? map}) async {
    Either<Failure, CalendarEntity> response;
    if (map == null) {
      response = await _repositoryImplementation.getSavedCalendar();
    } else {
      response = await _repositoryImplementation.getCalendar(map);
    }
    response.fold((l) => null, (r) => calendarEntity = r);
    List<SingleCalendarObject> list = calendarEntity?.list ?? [];
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
}
