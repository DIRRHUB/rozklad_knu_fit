import 'package:hive/hive.dart';

import '../single_calendar_object.dart';

part 'calendar_model.g.dart';

@HiveType(typeId: 0)
class CalendarModel extends HiveObject {
  @HiveField(0)
  final List<SingleCalendarObject> list;

  CalendarModel({required this.list});
}
