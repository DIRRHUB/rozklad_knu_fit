import 'package:flutter/material.dart';

class DayObject {
  final String? name;
  final String? time;
  final int? date;
  final Color colorType;
  final String? link;
  final String? teacher;
  final String type;

  DayObject(
      {this.name,
      this.time,
      this.date,
      this.colorType = Colors.white,
      this.link,
      this.teacher,
      this.type = ""});
}
