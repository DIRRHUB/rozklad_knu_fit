import 'package:flutter/material.dart';
import 'package:rozklad_knu_fit/presentation/view_models/home_view_model.dart';

import '../../data/models/day_object.dart';

class HomeModel extends ChangeNotifier {
  final HomeViewModel _viewModel = HomeViewModel();
  late Future<bool> _isEmptyLocalDataSource;
  Map<int, DayObject> mapTable = {};
  List<List<int>> matrixTable =
      List.generate(6, (i) => List.filled(7, 0), growable: false);

  get isEmptyLocalDataSource => _isEmptyLocalDataSource;

  HomeModel() {
    isEmpty();
    initMapTable();
  }

  void initMapTable() async {
    mapTable = await _viewModel.getMapTable();
    matrixTable = await _viewModel.getMatrixTable();
    notifyListeners();
  }

  void initNewMapTable(Map<String, String> map) async {
    mapTable = await _viewModel.getNewMapTable(map);
    matrixTable = await _viewModel.getMatrixTable();
    notifyListeners();
  }

  void isEmpty() async {
    _isEmptyLocalDataSource = _viewModel.isEmpty();
    notifyListeners();
  }
}
