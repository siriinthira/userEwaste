import 'package:flutter/material.dart';

class tracking extends StatefulWidget {
  const tracking({super.key});

  @override
  State<tracking> createState() => _trackingState();
}

class _trackingState extends State<tracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ติดตามสถานะการขนส่ง'),
      ),
      body: Center(),
    );
  }
}
