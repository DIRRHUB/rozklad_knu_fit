import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rozklad_knu_fit/internal/resources/colors.dart';
import 'package:rozklad_knu_fit/presentation/models/home_model.dart';

class TablePageWidget extends StatelessWidget {
  const TablePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeModel model = context.watch<HomeModel>();
    List<List<int>> matrix = model.matrixTable;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const _RowNameWeekWidget(),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                (matrix[0][5] == 1 || matrix[0][6] == 1)
                    ? const SizedBox()
                    : _RowTableWidget(row: matrix[0]),
                _RowTableWidget(row: matrix[1]),
                _RowTableWidget(row: matrix[2]),
                _RowTableWidget(row: matrix[3]),
                _RowTableWidget(row: matrix[4]),
                (matrix[5][0] == 0)
                    ? const SizedBox()
                    : _RowTableWidget(row: matrix[5]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RowTableWidget extends StatelessWidget {
  const _RowTableWidget({Key? key, required this.row}) : super(key: key);
  final List<int> row;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _OneDayWeek(
          color: AppColors.primaryColor,
          date: row[0],
        ),
        _OneDayWeek(
          color: AppColors.secondaryColor,
          date: row[1],
        ),
        _OneDayWeek(
          color: AppColors.primaryColor,
          date: row[2],
        ),
        _OneDayWeek(
          color: AppColors.secondaryColor,
          date: row[3],
        ),
        _OneDayWeek(
          color: AppColors.primaryColor,
          date: row[4],
        ),
      ],
    );
  }
}

class _OneDayWeek extends StatelessWidget {
  const _OneDayWeek({
    Key? key,
    required this.color,
    required this.date,
  }) : super(key: key);
  final int date;
  final Color color;

  void onItemTap(int selectedItem, BuildContext context) {
    if (selectedItem != 0) {
      context.read<HomeModel>().itemSelected(selectedItem, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeModel model = context.watch<HomeModel>();
    final selectedDay = date;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: color,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => onItemTap(selectedDay, context),
              child: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      (selectedDay != 0) ? selectedDay.toString() : "",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      (selectedDay != 0)
                          ? model.daysExistTable[selectedDay - 1]
                              ? "Пари"
                              : "Немає"
                          : "",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RowNameWeekWidget extends StatelessWidget {
  const _RowNameWeekWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _OneDayNameWeek(
          color: AppColors.primaryColor,
          text: "ПН",
        ),
        _OneDayNameWeek(
          color: AppColors.secondaryColor,
          text: "ВТ",
        ),
        _OneDayNameWeek(
          color: AppColors.primaryColor,
          text: "СР",
        ),
        _OneDayNameWeek(
          color: AppColors.secondaryColor,
          text: "ЧТ",
        ),
        _OneDayNameWeek(
          color: AppColors.primaryColor,
          text: "ПТ",
        ),
      ],
    );
  }
}

class _OneDayNameWeek extends StatelessWidget {
  const _OneDayNameWeek({Key? key, required this.color, required this.text})
      : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: color,
          ),
          child: Center(child: Text(text, style: tableTextStyle()))),
    ));
  }

  TextStyle tableTextStyle() =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
}
