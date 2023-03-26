import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:ui';

import 'package:user/models/item_model.dart';
import 'package:user/views/form.dart';
import 'package:user/widgets/dropdown_button.dart';
import 'package:user/widgets/widget_text.dart';
import 'package:url_launcher/url_launcher.dart';

class sendItemAutoLocate extends StatefulWidget {
  const sendItemAutoLocate({super.key});

  @override
  State<sendItemAutoLocate> createState() => _sendItemAutoLocateState();
}

class _sendItemAutoLocateState extends State<sendItemAutoLocate> {
  //insert item into the table
  var db = new Mysql();
  double? pick_lat;
  double? pick_lng;
  int pickup_type_id = 2; //drop down
  var bin_id = "";
  var item_id = ""; //ดูหน้ารายการขยะ

  final itemIdController = TextEditingController();
  final BinIdController = TextEditingController();
  final pickUpLatController = TextEditingController();
  final pickUpLngController = TextEditingController();

  void insertData() async {
    final now = DateTime.now();
    db.getConnection().then((conn) {
      String sqlQuery =
          'INSERT INTO `ewastedb`.`request` (`item_id`, `pick_lat`, `pick_lng`, `bin_id`, `pickup_type_id`, `req_date` ) VALUES (?, ?, ?, ?, ?, ?)';
      conn.query(sqlQuery, [
        itemIdController.text,
        pickUpLatController.text,
        pickUpLngController.text,
        BinIdController.text,
        pickup_type_id,
        now.toString()
      ]);
      setState(() {});
      print("Data Added");
      print(itemIdController.text);
      print(BinIdController.text);
      print(pickUpLatController.text);
      print(pickUpLngController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    itemIdController.dispose();
    BinIdController.dispose();
    pickUpLatController.dispose();
    pickUpLngController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var key;
    return Scaffold(
      appBar: AppBar(
        title: Text("นำส่งขยะด้วยตนเอง"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          Text('คลิกที่ปุ่ม ดูรายการขยะ เพื่อตรวจสอบหมายเลขขยะ'),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: itemIdController,
            decoration: InputDecoration(
                hintText: "โปรดหมายเลขขยะอิเล็กทรอนิกส์",
                border: OutlineInputBorder()),
          ),
          SizedBox(height: 15),
          Text('กรุณา คัดลอก ละติจูด ใต้แผนที่'),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: pickUpLatController,
            decoration: const InputDecoration(
                hintText: "กรุณากรอก ละติจูด ", border: OutlineInputBorder()),
          ),
          SizedBox(height: 15),
          Text('กรุณา คัดลอก ลองจิจูด ใต้แผนที่'),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: pickUpLngController,
            decoration: const InputDecoration(
                hintText: "กรุณากรอก ลองจิจูด ", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 15),
          Text('แสกนคิวอาร์โค้ดเพื่อรับหมายเลขขยะ'),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: BinIdController,
            decoration: const InputDecoration(
                hintText: "คัดลอกหมายเลขถังขยะและกดวางในช่องนี้",
                border: OutlineInputBorder()),
            validator: (value) {
              if (value!.isEmpty) {
                return 'โปรดระบุจำนวนสินค้า = 1';
              } else if (int.parse(value) != 1) {
                return "สามารถเพิ่มสินค้าได้ครั้งละหนึ่งรายการ";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              insertData();
              print('Data inserted successfully!');
            },
            child: const Text('Insert data'),
          ),
        ],
      ),
    );
  }
}

class Mysql {
  static String host = 'utcccs.cj5octuotk3f.ap-northeast-1.rds.amazonaws.com',
      user = 'ewuser',
      password = 'ewuser123',
      db = 'ewastedb';

  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}

/*
Pick or capture image using image_picker
Upload the image to Firebase storage
Get the URL of the uploaded image
Store the image URL inside the corresponding document in database

 */


//https://www.youtube.com/watch?v=nEcb3ieAICs
//https://www.youtube.com/watch?v=c2tGUt7FLqY
//https://www.youtube.com/watch?v=7XOQAtSTw4s
// https://www.youtube.com/watch?v=g8WEXj6xvsY
/*

http method = post
enctype = multiport / form data
 */
