import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rozklad_knu_fit/internal/navigation/navigation_routes.dart';
import '../../data/datasources/local/local_datasource.dart';
import '../../data/datasources/remote/remote_datasourse.dart';
import '../../data/models/day_object.dart';
import '../../data/models/single_calendar_object.dart';
import '../../data/repositories/repository_implementation.dart';
import '../../domain/entities/calendar_entity.dart';
import '../../internal/error/failure.dart';
import '../../internal/resources/colors.dart';

class TableViewModel extends ChangeNotifier {
  final RepositoryImplementation _repository = RepositoryImplementation(
    localDataSource: LocalDataSource(),
    remoteDataSource: RemoteDataSource(),
  );
  CalendarEntity _calendarEntity = const CalendarEntity(list: []);
  Map<int, List<DayObject>> _mapTable = {};
  List<List<int>> _matrixTable =
      List.generate(6, (i) => List.filled(7, 0), growable: false);
  List<bool> daysExistTable = List.filled(31, false);
  late int _intStartDate;
  late int _intEndDate;
  late int _intMaxDay;
  late Future<bool> _isEmptyLocalDataSource;

  get isEmptyLocalDataSource => _isEmptyLocalDataSource;
  Map<int, List<DayObject>> get mapTable => _mapTable;
  List<List<int>> get matrixTable => _matrixTable;

  TableViewModel() {
    isEmpty();
    initMapTable();
    notifyListeners();
  }

  void initMapTable() async {
    _mapTable = await getMapTable();
    _matrixTable = await getMatrixTable();
    await isDaysExists();
    notifyListeners();
  }

  Future<Map<int, List<DayObject>>> getMapTable() async {
    Either<Failure, CalendarEntity> response;
    response = await _repository.getCalendar();
    response.fold((l) {}, (r) => _calendarEntity = r);

    List<SingleCalendarObject> list = _calendarEntity.list;
    Map<int, List<DayObject>> mapResult = {};
    setCurrentDate();
    if (list.isNotEmpty) {
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

  void isEmpty() {
    _isEmptyLocalDataSource = _repository.localDataSource.isEmpty();
    notifyListeners();
  }

  void itemSelected(int item, BuildContext context) {
    if (_mapTable.containsKey(item)) {
      Navigator.of(context)
          .pushNamed(NavigationRoutes.details, arguments: item);
    } else {
      Fluttertoast.showToast(
          msg: "Пар немає",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  List<DayObject> getItemInformation(item) {
    return _mapTable[item]!;
  }

  Future<void> isDaysExists() async {
    List daysList = List.filled(42, 0);
    int index = 0;
    for (var x in _matrixTable) {
      for (var y in x) {
        daysList[index++] = y;
      }
    }
    index = 0;
    for (int i = 0; i < daysList.length; i++) {
      if (daysList[i] != 0) {
        if (_mapTable.containsKey(daysList[i])) {
          daysExistTable[index] = true;
        } else {
          daysExistTable[index] = false;
        }
        index++;
      }
    }
    notifyListeners();
  }
}
