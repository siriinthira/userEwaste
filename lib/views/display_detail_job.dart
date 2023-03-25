// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:user/models/job_model.dart';
import 'package:user/controller/app_controller.dart';
import 'package:user/widgets/widget_map.dart';
import 'package:user/widgets/widget_text.dart';

class DisplayDetailJob extends StatefulWidget {
  const DisplayDetailJob({
    Key? key,
    required this.jobModel,
  }) : super(key: key);

  final JobModel jobModel;

  @override
  State<DisplayDetailJob> createState() => _DisplayDetailJobState();
}

class _DisplayDetailJobState extends State<DisplayDetailJob> {
  Set<Marker> setMarkers = <Marker>[].toSet();
  AppController controller = Get.put(AppController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Marker loginMarker = Marker(
      markerId: MarkerId('login'),
      position: LatLng(controller.loginPositions.last.latitude,
          controller.loginPositions.last.longitude),
      infoWindow: InfoWindow(title: 'คุณอยู่ที่นี่'),
    );
    setMarkers.add(loginMarker);

    Marker jobMarker = Marker(
        markerId: MarkerId('job'),
        position: LatLng(
          double.parse(widget.jobModel.lat.trim()),
          double.parse(
            widget.jobModel.lng.trim(),
          ),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(120),
        infoWindow: InfoWindow(title: 'ที่ส่งสินค้า'));
    setMarkers.add(jobMarker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(data: 'รายละเอียดของงาน = ${widget.jobModel}'),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              print('loginPosition --> ${appController.loginPositions.length}');
              return ListView(
                children: [
                  appController.loginPositions.isEmpty
                      ? const SizedBox()
                      : SizedBox(
                          width: boxConstraints.maxWidth,
                          height: boxConstraints.maxWidth,
                          child: WidgetMap(
                            position: appController.loginPositions.last,
                            setMarkers: setMarkers,
                          )),
                ],
              );
            });
      }),
    );
  }
}
