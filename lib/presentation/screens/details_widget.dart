import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rozklad_knu_fit/data/models/day_object.dart';
import 'package:rozklad_knu_fit/internal/launcher_url.dart';
import 'package:rozklad_knu_fit/internal/resources/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view_models/table_view_model.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)?.settings.arguments;
    List<DayObject> dayObject =
        context.read<TableViewModel>().getItemInformation(item);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            splashColor: AppColors.primaryColor,
                            onTap: () =>
                                LauncherURL.launch(dayObject[index].link ?? ""),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  dayObject[index].name ?? "",
                                  style: const TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      dayObject[index].type,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.2,
                                          ),
                                          shape: BoxShape.circle,
                                          color: dayObject[index].colorType),
                                    ),
                                  ],
                                ),
                                Text(
                                  dayObject[index].time ?? "",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(dayObject[index].teacher ?? ""),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: dayObject.length),
            ),
          ],
        ),
      ),
    );
  }
}
