import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rozklad_knu_fit/internal/resources/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherURL {
  static void launch(String url) async {
    url = fixUrl(url);
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      FlutterClipboard.copy(url);
      Fluttertoast.showToast(
          msg: "Посилання скопійоване",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  static String fixUrl(String url) {
    //WRONG TYPES OF URL
    if (url.contains("meet.google.com")) {
      url = "http://$url";
    }
    return url;
  }
}
