import 'package:flutter/material.dart';
import 'package:user/views/sendItem.dart';

class ViewItemList extends StatefulWidget {
  const ViewItemList({super.key});

  @override
  State<ViewItemList> createState() => _ViewItemListState();
}

class _ViewItemListState extends State<ViewItemList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ดูรายการและตรวจสอบหมายเลขขยะ'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('กลับไปหน้านำส่งสินค้าด้วยตนเอง'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => sendItem()),
            );
          },
        ),
      ),
    );
  }
}
