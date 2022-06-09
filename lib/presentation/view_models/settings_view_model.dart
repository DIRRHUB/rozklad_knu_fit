import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/datasources/local/local_datasource.dart';
import '../../data/datasources/remote/remote_datasourse.dart';
import '../../data/repositories/repository_implementation.dart';
import '../../domain/entities/specs_entity.dart';
import '../../internal/error/failure.dart';
import '../../internal/resources/colors.dart';
import '../../internal/resources/dropdown_menu_const.dart';

class SettingsViewModel extends ChangeNotifier {
  final RepositoryImplementation _repository = RepositoryImplementation(
    localDataSource: LocalDataSource(),
    remoteDataSource: RemoteDataSource(),
  );
  SpecsEntity _specsEntity = const SpecsEntity();
  String selectedCourse = DropdownMenuConst.courseChoose;
  String selectedGroup = DropdownMenuConst.groupChoose;
  List<String> courseList = [];
  List<String> groupList = [];
  String _startCalendarTime = "", _endCalendarTime = "";
  bool loadingStatus = false;

  set setCourse(String value) {
    selectedCourse = value;
    groupList.clear();
    selectedGroup = DropdownMenuConst.groupChoose;
    setGroupDropdownItems();
  }

  set setGroup(String value) => selectedGroup = value;

  SettingsViewModel() {
    initSpecs();
  }

  void initSpecs() async {
    Either<Failure, SpecsEntity> result = await _repository.getSpecs();
    result.fold(
      (l) => null,
      (r) {
        _specsEntity = r;
        setCourseDropdownItems();
      },
    );
  }

  void setCourseDropdownItems() {
    courseList.clear();
    courseList.add(DropdownMenuConst.course1);
    courseList.add(DropdownMenuConst.course2);
    courseList.add(DropdownMenuConst.course3);
    courseList.add(DropdownMenuConst.course4);
    courseList.add(DropdownMenuConst.course5);
    courseList.add(DropdownMenuConst.teacher);
    notifyListeners();
    setGroupDropdownItems();
  }

  void setGroupDropdownItems() {
    List<String> setGroup(List<String> list) {
      List<String> items = [];
      for (var element in list) {
        items.add(element);
      }
      return items;
    }

    switch (selectedCourse) {
      case DropdownMenuConst.course1:
        groupList = setGroup(_specsEntity.list1Course);
        break;
      case DropdownMenuConst.course2:
        groupList = setGroup(_specsEntity.list2Course);
        break;
      case DropdownMenuConst.course3:
        groupList = setGroup(_specsEntity.list3Course);
        break;
      case DropdownMenuConst.course4:
        groupList = setGroup(_specsEntity.list4Course);
        break;
      case DropdownMenuConst.course5:
        groupList = setGroup(_specsEntity.list5Course);
        break;
      case DropdownMenuConst.teacher:
        groupList = setGroup(_specsEntity.listTeachers);
    }
    notifyListeners();
  }

  void save() async {
    if (selectedCourse != DropdownMenuConst.courseChoose &&
        selectedGroup != DropdownMenuConst.groupChoose) {
      loadingStatus = true;
      notifyListeners();
      if (_startCalendarTime.isEmpty || _endCalendarTime.isEmpty) {
        evaluateCalendarTime();
      }
      var fixedSelectedCourseValue = selectedCourse;
      if (selectedCourse == DropdownMenuConst.teacher) {
        fixedSelectedCourseValue = DropdownMenuConst.teacherCourse;
      }
      var mapRequest = {
        "spec": fixedSelectedCourseValue,
        "group": selectedGroup,
        "start": _startCalendarTime,
        "end": _endCalendarTime
      };
      var response = await _repository.getCalendar(map: mapRequest);
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
      loadingStatus = false;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: "Виберіть курс та групу",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void evaluateCalendarTime() {
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    if (currentMonth >= 9) {
      _startCalendarTime = "${now.year}-09-01T00:00:00+01:00";
      _endCalendarTime = "${now.year}-12-31T00:00:00+01:00";
    } else {
      _startCalendarTime = "${now.year}-01-01T00:00:00+01:00";
      _endCalendarTime = "${now.year}-07-01T00:00:00+01:00";
    }
  }
}
