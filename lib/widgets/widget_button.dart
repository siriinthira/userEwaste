// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:user/utility/app_constant.dart';

import 'package:user/widgets/widget_text.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.size,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        child: ElevatedButton(
            onPressed: pressFunc,
            child: WidgetText(
              data: label,
              textStyle: AppConstant().h3Style(fontWeight: FontWeight.bold),
            )));
  }
}
