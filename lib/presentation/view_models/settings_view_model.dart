import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/entities/specs_entity.dart';
import '../../internal/resources/colors.dart';
import '../../internal/resources/dropdown_menu_const.dart';
import '../model/model.dart';

class SettingsViewModel extends ChangeNotifier {
  final Model _model = Model();
  SpecsEntity? _specsEntity;
  String selectedCourse = DropdownMenuConst.courseChoose;
  String selectedGroup = DropdownMenuConst.groupChoose;
  List<String> courseList = [];
  List<String> groupList = [];

  SettingsViewModel() {
    initSpecs();
  }

  void initSpecs() {
    _model
        .getSpecs()
        .then((value) => _specsEntity = value)
        .whenComplete(() => setCourseDropdownItems());
  }

  void setCourseDropdownItems() {
    if (_specsEntity != null) {
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
  }

  void setGroupDropdownItems() {
    List<String> setGroup(List<String> list) {
      List<String> items = [];
      for (var element in list) {
        items.add(element);
      }
      return items;
    }

    if (_specsEntity != null) {
      switch (selectedCourse) {
        case DropdownMenuConst.course1:
          groupList = setGroup(_specsEntity!.list1Course);
          break;
        case DropdownMenuConst.course2:
          groupList = setGroup(_specsEntity!.list2Course);
          break;
        case DropdownMenuConst.course3:
          groupList = setGroup(_specsEntity!.list3Course);
          break;
        case DropdownMenuConst.course4:
          groupList = setGroup(_specsEntity!.list4Course);
          break;
        case DropdownMenuConst.course5:
          groupList = setGroup(_specsEntity!.list5Course);
          break;
        case DropdownMenuConst.teacher:
          groupList = setGroup(_specsEntity!.listTeachers);
      }
      notifyListeners();
    }
  }

  void save() async {
    if (selectedCourse != DropdownMenuConst.courseChoose &&
        selectedGroup != DropdownMenuConst.groupChoose) {
      var specsTime = _model.evaluateCalendarTime();
      String? startTime = specsTime["start"];
      String? endTime = specsTime["end"];
      if (startTime != null && endTime != null) {
        var fixedSelectedCourseValue = selectedCourse;
        if (selectedCourse == DropdownMenuConst.teacher) {
          fixedSelectedCourseValue = DropdownMenuConst.teacherCourse;
        }
        var mapRequest = {
          "spec": fixedSelectedCourseValue,
          "group": selectedGroup,
          "start": startTime,
          "end": endTime
        };
        _model.getMapTable(map: mapRequest);
      }
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

  set setCourse(String value) {
    selectedCourse = value;
    groupList.clear();
    selectedGroup = DropdownMenuConst.groupChoose;
    setGroupDropdownItems();
  }

  set setGroup(String value) => selectedGroup = value;
}
