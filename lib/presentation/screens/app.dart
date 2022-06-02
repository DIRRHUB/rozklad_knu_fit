import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rozklad_knu_fit/internal/navigation/navigation_routes.dart';
import 'package:rozklad_knu_fit/presentation/models/home_model.dart';
import 'package:rozklad_knu_fit/presentation/screens/details_widget.dart';
import 'package:rozklad_knu_fit/presentation/screens/home_widget.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeModel(),
      child: MaterialApp(
        title: 'Розклад',
        initialRoute: '/',
        routes: {
          NavigationRoutes.root: (context) => const HomeWidget(),
          NavigationRoutes.details: (context) => const DetailsWidget(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}