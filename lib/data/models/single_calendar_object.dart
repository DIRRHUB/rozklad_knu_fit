import 'package:hive/hive.dart';

part 'single_calendar_object.g.dart';

@HiveType(typeId: 3)
class SingleCalendarObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String teacher;
  @HiveField(2)
  final String time;
  @HiveField(3)
  final bool online;
  @HiveField(4)
  final num start;
  @HiveField(5)
  final num end;
  @HiveField(6)
  final String backgroundColor;
  @HiveField(7)
  final String type;
  @HiveField(8)
  final String url;

  SingleCalendarObject({
    required this.title,
    required this.teacher,
    required this.time,
    required this.online,
    required this.start,
    required this.end,
    required this.backgroundColor,
    required this.type,
    required this.url,
  });
}
