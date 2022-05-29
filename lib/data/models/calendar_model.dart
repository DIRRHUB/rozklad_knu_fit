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
          online: element['online'] as bool,
          start: element['start'] as num,
          end: element['end'] as num,
          backgroundColor: element['backgroundColor'] as String,
          type: element['type'],
          url: element['url'] as String,
        ),
      );
    }
    return CalendarModel(listObjects);
  }
}

class SingleCalendarObject {
  final String title;
  final String teacher;
  final String time;
  final bool online;
  final num start;
  final num end;
  final String backgroundColor;
  final String type;
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
