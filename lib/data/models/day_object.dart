import 'package:flutter/material.dart';

class DayObject {
  final String name;
  final String time;
  final int date;
  final Color colorType;

  DayObject(
      {this.name = "?",
      this.time = "?",
      this.date = 1,
      this.colorType = Colors.white});
}
