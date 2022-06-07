import 'package:flutter/material.dart';
import 'package:rozklad_knu_fit/presentation/pages/list_page/list_page.dart';
import 'package:rozklad_knu_fit/presentation/pages/settings_page/settings_page.dart';
import 'package:rozklad_knu_fit/presentation/pages/table_page/table_page.dart';
import 'package:provider/provider.dart';
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
          selectedItemColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              label: 'Table',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
