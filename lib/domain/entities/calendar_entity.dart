import 'package:equatable/equatable.dart';
import '../../data/models/single_calendar_object.dart';

class CalendarEntity extends Equatable {
  final List<SingleCalendarObject> list;

  const CalendarEntity({
    required this.list,
  });

  @override
  List<Object?> get props => [list];
}
