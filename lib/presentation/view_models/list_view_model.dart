import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rozklad_knu_fit/data/models/day_object.dart';
import '../../data/datasources/local/local_datasource.dart';
import '../../data/datasources/remote/remote_datasourse.dart';
import '../../data/models/single_calendar_object.dart';
import '../../data/repositories/repository_implementation.dart';
import '../../domain/entities/calendar_entity.dart';
import '../../internal/error/failure.dart';
import '../../internal/resources/colors.dart';

class ListViewModel extends ChangeNotifier {
  final RepositoryImplementation _repository = RepositoryImplementation(
    localDataSource: LocalDataSource(),
    remoteDataSource: RemoteDataSource(),
  );
  CalendarEntity _calendarEntity = const CalendarEntity(list: []);
  List<List<DayObject>> list = [];
  int currentDayIndex = 0;

  ListViewModel() {
    initMapList();
  }

  void initMapList() async {
    list = await getList();
    setCurrentDayIndex();
    notifyListeners();
  }

  Future<List<List<DayObject>>> getList() async {
    final Either<Failure, CalendarEntity> response;
    response = await _repository.getCalendar();
    response.fold((l) {}, (r) => _calendarEntity = r);
    final List<SingleCalendarObject> list = _calendarEntity.list;
    final Map<String, List<DayObject>> map = {};
    final List<List<DayObject>> listResult = [];

    if (list.isNotEmpty) {
      list.sort((a, b) {
        if (a.start > b.start) {
          return 1;
        } else if (a.start < b.start) {
          return -1;
        } else {
          return 0;
        }
      });
      for (int i = 0; i < list.length; i++) {
        final Color typeColor;
        final String typeLesson;
        if (list[i].backgroundColor == "blue") {
          typeColor = AppColors.practiceColor;
          typeLesson = "Практика";
        } else {
          typeColor = AppColors.lectureColor;
          typeLesson = "Лекція";
        }
        final dateTime =
            DateTime.fromMillisecondsSinceEpoch(list[i].start as int);

        final String date =
            "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}";
        var dayObject = DayObject(
          name: list[i].title,
          time: list[i].time,
          date: date,
          colorType: typeColor,
          link: list[i].url,
          teacher: list[i].teacher,
          type: typeLesson,
        );
        if (map.containsKey(date)) {
          map[date]!.add(dayObject);
        } else {
          map[date] = [dayObject];
        }
      }
    }
    map.forEach((k, v) => listResult.add(v));
    return listResult;
  }

  setCurrentDayIndex() {
    if (list.isNotEmpty) {
      final dateTime = DateTime.now();
      final currentDate =
          "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}";
      currentDayIndex =
          list.indexWhere((element) => element[0].date == currentDate);
      if (currentDayIndex == -1) currentDayIndex = 0;
      notifyListeners();
    }
  }
}
