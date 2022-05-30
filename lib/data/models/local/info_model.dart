import 'package:hive/hive.dart';

part 'info_model.g.dart';

@HiveType(typeId: 1)
class InfoModel extends HiveObject {
  @HiveField(0)
  final num date;
  @HiveField(1)
  final List<String> listTeachers;

  InfoModel({required this.date, required this.listTeachers});
}
