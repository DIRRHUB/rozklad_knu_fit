import '../single_calendar_object.dart';

class CalendarModel {
  final List<SingleCalendarObject> list;

  const CalendarModel(this.list);

  factory CalendarModel.fromJson(List<dynamic> json) {
    List list = json;
    List<SingleCalendarObject> listObjects = [];
    for (var element in list) {
      listObjects.add(
        SingleCalendarObject(
          title: element['title'] as String,
          teacher: element['teacher'] as String,
          time: element['_time'] as String,
          online: element['online'] as bool?,
          start: element['start'] as num,
          end: element['end'] as num,
          backgroundColor: element['backgroundColor'] as String,
          type: element['type'] as String,
          url: element['url'] as String?,
        ),
      );
    }
    return CalendarModel(listObjects);
  }
}
