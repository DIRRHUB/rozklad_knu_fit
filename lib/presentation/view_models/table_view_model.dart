import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rozklad_knu_fit/internal/navigation/navigation_routes.dart';
import '../../data/models/day_object.dart';
import '../../internal/resources/colors.dart';
import '../model/model.dart';

class TableViewModel extends ChangeNotifier {
  final Model _model = Model();
  late Future<bool> _isEmptyLocalDataSource;
  Map<int, List<DayObject>> mapTable = {};
  List<List<int>> matrixTable =
      List.generate(6, (i) => List.filled(7, 0), growable: false);
  List<bool> daysExistTable = List.filled(31, false);

  get isEmptyLocalDataSource => _isEmptyLocalDataSource;

  TableViewModel() {
    isEmpty();
    initMapTable();
    notifyListeners();
  }

  void initMapTable() async {
    mapTable = await _model.getMapTable();
    matrixTable = await _model.getMatrixTable();
    await isDaysExists();
    notifyListeners();
  }

  void isEmpty() {
    _isEmptyLocalDataSource = _model.isEmpty();
    notifyListeners();
  }

  void itemSelected(int item, BuildContext context) {
    if (mapTable.containsKey(item)) {
      Navigator.of(context)
          .pushNamed(NavigationRoutes.details, arguments: item);
    } else {
      Fluttertoast.showToast(
          msg: "Пар немає",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  List<DayObject> getItemInformation(item) {
    return mapTable[item]!;
  }

  Future<void> isDaysExists() async {
    daysExistTable = await _model.isDayExists(matrixTable, mapTable);
    notifyListeners();
  }
}
