import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/models/job_model.dart';
import 'package:user/views/display_detail_job.dart';
import 'package:user/widgets/widget_button.dart';
import 'package:user/widgets/widget_text.dart';

class ReceiveJobDriver extends StatefulWidget {
  const ReceiveJobDriver({super.key});

  @override
  State<ReceiveJobDriver> createState() => _ReceiveJobDriverState();
}

class _ReceiveJobDriverState extends State<ReceiveJobDriver> {


  JobModel testJobModel = JobModel(
      idUser: '1',
      weightJob: '20',
      lat: '13.77859117066963',
      lng: '100.56005771069849');


      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(data: 'รับงาน'),
      ),
      body: WidgetButton(
        label: 'Test',
        pressFunc: () {
          Get.to(DisplayDetailJob(jobModel: testJobModel));
        },
      ),
    );
  }
}
