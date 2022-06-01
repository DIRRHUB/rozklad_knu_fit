import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rozklad_knu_fit/presentation/models/home_model.dart';

class SettingsPageWidget extends StatelessWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeModel model = context.watch<HomeModel>();
    return Container(
        color: Colors.green,
        child: OutlinedButton(
          onPressed: () {
            model.initNewMapTable({
              "spec": "1 курс",
              "group": "підгрупа ПП-11/2",
              "start": "2022-01-31T00:00:00+01:00",
              "end": "2022-06-14T00:00:00+01:00"
            });
          },
          child: Text("Test"),
        ));
  }
}
