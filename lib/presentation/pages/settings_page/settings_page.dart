import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:provider/provider.dart';

import '../../../internal/my_connectivity.dart';
import '../../../internal/resources/colors.dart';
import '../../view_models/settings_view_model.dart';

class SettingsPageWidget extends StatefulWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

  @override
  State<SettingsPageWidget> createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
  final MyConnectivity _connectivity = MyConnectivity.instance;
  Map _source = {ConnectivityResult.none: false};
  @override
  void initState() {
    super.initState();
    _connectivity.init();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  void onPressedUpdateButton(SettingsViewModel viewModel) {
    viewModel.initSpecs();
  }

  @override
  Widget build(BuildContext context) {
    if (_source.keys.toList()[0] == ConnectivityResult.mobile ||
        _source.keys.toList()[0] == ConnectivityResult.wifi) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: const [
              _CourseMenuWidget(),
              SizedBox(height: 5),
              _GroupMenuWidget(),
              SizedBox(height: 5),
              _SaveButtonWidget(),
            ],
          ),
        ),
      );
    } else {
      return const Center(
          child: Text(
        "Немає інтернет підключення",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ));
    }
  }
}

class _CourseMenuWidget extends StatefulWidget {
  const _CourseMenuWidget({Key? key}) : super(key: key);

  @override
  State<_CourseMenuWidget> createState() => _CourseMenuWidgetState();
}

class _CourseMenuWidgetState extends State<_CourseMenuWidget> {
  late ExpandedTileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ExpandedTileController(isExpanded: false);
  }

  void setSelectedValue(SettingsViewModel viewmodel, int index) {
    viewmodel.setCourse = viewmodel.courseList[index];
    _controller.collapse();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel viewmodel = context.watch<SettingsViewModel>();
    return ExpandedTile(
      theme: const ExpandedTileThemeData(
        headerColor: AppColors.primaryColor,
        headerRadius: 8.0,
        contentBackgroundColor: AppColors.primaryColor,
        contentPadding: EdgeInsets.all(0),
      ),
      controller: _controller,
      title: Text(viewmodel.selectedCourse, style: textStyle()),
      content: ListView.separated(
        itemBuilder: ((context, index) {
          return ListTile(
            title: Text(
              viewmodel.courseList[index],
              style: textStyle(),
            ),
            onTap: () => setSelectedValue(viewmodel, index),
          );
        }),
        separatorBuilder: ((context, index) {
          return Container(height: 1, color: Colors.white);
        }),
        itemCount: viewmodel.courseList.length,
        shrinkWrap: true,
      ),
    );
  }
}

class _GroupMenuWidget extends StatefulWidget {
  const _GroupMenuWidget({Key? key}) : super(key: key);

  @override
  State<_GroupMenuWidget> createState() => _GroupMenuWidgetState();
}

class _GroupMenuWidgetState extends State<_GroupMenuWidget> {
  late ExpandedTileController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ExpandedTileController(isExpanded: false);
  }

  void setSelectedValue(SettingsViewModel model, int index) {
    model.setGroup = model.groupList[index];
    _controller.collapse();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel model = context.watch<SettingsViewModel>();
    return ExpandedTile(
      theme: const ExpandedTileThemeData(
        headerColor: AppColors.primaryColor,
        headerRadius: 8.0,
        contentBackgroundColor: AppColors.primaryColor,
        contentPadding: EdgeInsets.all(0),
      ),
      controller: _controller,
      title: Text(model.selectedGroup, style: textStyle()),
      content: ListView.separated(
        itemBuilder: ((context, index) {
          return ListTile(
            title: Text(
              model.groupList[index],
              style: textStyle(),
            ),
            onTap: () => setSelectedValue(model, index),
          );
        }),
        separatorBuilder: ((context, index) {
          return Container(height: 1, color: Colors.white);
        }),
        itemCount: model.groupList.length,
        shrinkWrap: true,
      ),
    );
  }
}

class _SaveButtonWidget extends StatelessWidget {
  const _SaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel model = context.watch<SettingsViewModel>();
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        onPressed: () => model.save(),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        child: Text(
          "Зберегти",
          style: textStyle(),
        ),
      ),
    );
  }
}

TextStyle textStyle() {
  return const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}
