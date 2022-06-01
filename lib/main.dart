import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rozklad_knu_fit/data/datasources/local/local_datasource.dart';
import 'package:rozklad_knu_fit/data/models/single_calendar_object.dart';
import 'package:rozklad_knu_fit/presentation/screens/app.dart';
import 'data/models/local/calendar_model.dart';
import 'data/models/local/info_model.dart';
import 'data/models/local/specs_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CalendarModelAdapter());
  Hive.registerAdapter(InfoModelAdapter());
  Hive.registerAdapter(SpecsModelAdapter());
  Hive.registerAdapter(SingleCalendarObjectAdapter());
  await Hive.openBox<dynamic>(BoxNames.infoBox);
  await Hive.openBox<dynamic>(BoxNames.specsBox);
  await Hive.openBox<dynamic>(BoxNames.calendarBox);

  runApp(const App());
}
