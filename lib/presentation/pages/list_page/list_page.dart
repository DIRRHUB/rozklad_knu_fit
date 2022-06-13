import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:provider/provider.dart';
import 'package:rozklad_knu_fit/presentation/view_models/list_view_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../internal/launcher_url.dart';
import '../../../internal/resources/colors.dart';

class ListPageWidget extends StatelessWidget {
  const ListPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.watch<ListViewModel>();
    if (viewmodel.list.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ScrollablePositionedList.separated(
          initialScrollIndex: viewmodel.currentDayIndex,
          itemCount: viewmodel.list.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpandedTile(
              theme: const ExpandedTileThemeData(
                headerColor: AppColors.primaryColor,
                headerRadius: 8.0,
                contentBackgroundColor: AppColors.primaryColor,
                contentPadding: EdgeInsets.all(0),
              ),
              controller: ExpandedTileController(),
              title: Text(
                viewmodel.list[index][0].date ?? "",
                style: primaryTitleTextStyle(),
              ),
              content: ListTile(
                title: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: ((context, indexInside) {
                    return Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        splashColor: AppColors.primaryColor,
                        onTap: () => LauncherURL.launch(
                            viewmodel.list[index][indexInside].link ?? ""),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                viewmodel.list[index][indexInside].name!,
                                style: primaryTitleTextStyle(),
                              ),
                              Row(
                                children: [
                                  Text(
                                    viewmodel.list[index][indexInside].type,
                                    style: secondaryTitleTextStyle(),
                                  ),
                                  const SizedBox(width: 2),
                                  Container(
                                    height: 14,
                                    width: 14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.2,
                                        ),
                                        shape: BoxShape.circle,
                                        color: viewmodel
                                            .list[index][indexInside]
                                            .colorType),
                                  ),
                                ],
                              ),
                              Text(
                                viewmodel.list[index][indexInside].time ?? "",
                                style: secondaryTitleTextStyle(),
                              ),
                              Text(
                                viewmodel.list[index][indexInside].teacher ??
                                    "",
                                style: secondaryTitleTextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  itemCount: viewmodel.list[index].length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.white,
              height: 5,
            );
          },
        ),
      );
    } else {
      return const Center(
          child: Text(
        "Оберіть курс та групу",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ));
    }
  }

  TextStyle primaryTitleTextStyle() =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  TextStyle secondaryTitleTextStyle() =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
}
