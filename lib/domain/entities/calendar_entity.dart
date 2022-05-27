import 'package:equatable/equatable.dart';
import 'package:rozklad_knu_fit/data/models/calendar_model.dart';

class CalendarEntity extends Equatable {
  final List<SingleCalendarObject> list;

  const CalendarEntity({required this.list});

  factory CalendarEntity.fromList(List<Map<String, dynamic>> list) {
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
          backgroundColor: element['backgroundColor'],
          type: ['type'] as String,
          url: ['url'] as String,
        ),
      );
    }
    return CalendarEntity(list: listObjects);
  }

  @override
  List<Object?> get props => [list];
}
