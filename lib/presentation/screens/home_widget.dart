import 'package:flutter/material.dart';
import 'package:rozklad_knu_fit/internal/resources/colors.dart';
import 'package:rozklad_knu_fit/presentation/pages/list_page/list_page.dart';
import 'package:rozklad_knu_fit/presentation/pages/settings_page/settings_page.dart';
import 'package:rozklad_knu_fit/presentation/pages/table_page/table_page.dart';
import 'package:provider/provider.dart';
import 'package:rozklad_knu_fit/presentation/view_models/list_view_model.dart';
import 'package:rozklad_knu_fit/presentation/view_models/table_view_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    TablePageWidget(),
    ListPageWidget(),
    SettingsPageWidget(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initLaunch(context);
    setState(() {});
  }

  void initLaunch(BuildContext context) async {
    if (await context.watch<TableViewModel>().isEmptyLocalDataSource) {
      _selectedIndex = 2;
    } else {
      _selectedIndex = 0;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        context.read<TableViewModel>().initMapTable();
      } else if (_selectedIndex == 1) {
        context.read<ListViewModel>().initMapList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Розклад'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              label: 'Таблиця',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Список',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Налаштування',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
