import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:user/controller/app_controller.dart';
import 'package:user/utility/app_dialog.dart';
import 'package:user/widgets/widget_text_button.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processFindPosition({required BuildContext context}) async {
    //check mobile permission
    bool locationServiceEnable = await Geolocator.isLocationServiceEnabled();

    LocationPermission locationPermission;

    if (locationServiceEnable) {
      //Enabled Service
      locationPermission = await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        //ไม่อณุญาตเลย
        permissionDialog(context);
      } else {
        //ไม่รู้ว่าอณุญาตหรือยัง
        if (locationPermission == LocationPermission.denied) {
          locationPermission = await Geolocator.requestPermission();
          if ((locationPermission != LocationPermission.always) &&
              (locationPermission != LocationPermission.whileInUse)) {
            permissionDialog(context);
          } else {
            //find Position
            Position position = await Geolocator.getCurrentPosition();
            appController.loginPositions.add(position);
          }
        } else {
          //find position
          Position position = await Geolocator.getCurrentPosition();
          appController.loginPositions.add(position);
        }
      }
    } else {
      //Disable Service
      AppDialog(context: context).normalDialog(
        title: 'Disable service location',
        subtitle: 'Please Open Service',
        listActions: [
          WidgetTextButton(
            label: 'Open Service',
            pressFunc: () {
              Geolocator.openLocationSettings();
              exit(0);
              // Get.back();
            },
          )
        ],
      );
    }
  }

  void permissionDialog(BuildContext context) {
    AppDialog(context: context).normalDialog(
        title: 'ไม่อณุญาต',
        subtitle: 'กรณุาตั้งค่าอณุญาตแชร์พิกัด',
        listActions: [
          WidgetTextButton(
              label: 'Permission Location',
              pressFunc: () {
                Geolocator.openAppSettings();
                exit(0);
              })
        ]);
  }
}
