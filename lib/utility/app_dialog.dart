// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/utility/app_constant.dart';
import 'package:user/widgets/widget_text.dart';

class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context,
  });

  void normalDialog(
      {required String title,
      required String subtitle,
      required List<Widget> listActions}) {
    Get.dialog(
      AlertDialog(
        title: WidgetText(
          data: title,
          textStyle: AppConstant().h2Style(),
        ),
        content: WidgetText(data: subtitle),
        actions: listActions,
      ),
      barrierDismissible: false,
    );
  }
}
