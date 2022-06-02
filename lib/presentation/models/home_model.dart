import 'package:flutter/material.dart';
import 'package:rozklad_knu_fit/internal/navigation/navigation_routes.dart';
import 'package:rozklad_knu_fit/presentation/view_models/home_view_model.dart';

import '../../data/models/day_object.dart';

class HomeModel extends ChangeNotifier {
  final HomeViewModel _viewModel = HomeViewModel();
  late Future<bool> _isEmptyLocalDataSource;
  Map<int, List<DayObject>> mapTable = {};
  List<List<int>> matrixTable =
      List.generate(6, (i) => List.filled(7, 0), growable: false);
  List<bool> daysExistTable = List.filled(31, false);

  get isEmptyLocalDataSource => _isEmptyLocalDataSource;

  HomeModel() {
    isEmpty();
    initMapTable();
  }

  void initMapTable() async {
    mapTable = await _viewModel.getMapTable();
    matrixTable = await _viewModel.getMatrixTable();
    await isDayExists();
    notifyListeners();
  }

  void initNewMapTable(Map<String, String> map) async {
    mapTable = await _viewModel.getMapTable(map: map);
    matrixTable = await _viewModel.getMatrixTable();
    await isDayExists();
    notifyListeners();
  }

  void isEmpty() async {
    _isEmptyLocalDataSource = _viewModel.isEmpty();
    notifyListeners();
  }

  void itemSelected(int item, BuildContext context) {
    if (mapTable.containsKey(item)) {
      Navigator.of(context)
          .pushNamed(NavigationRoutes.details, arguments: item);
    } else {}
  }

  List<DayObject> getItemInformation(item) {
    return mapTable[item]!;
  }

  Future<void> isDayExists() async {
    daysExistTable = await _viewModel.isDayExists(matrixTable, mapTable);
    notifyListeners();
  }
}
