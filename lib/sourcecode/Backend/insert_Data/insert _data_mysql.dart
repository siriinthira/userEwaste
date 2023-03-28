import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:ui';

import 'package:user/models/item_model.dart';
import 'package:user/sourcecode/Frontend/form.dart';
import 'package:user/widgets/dropdown_button.dart';
import 'package:user/widgets/widget_text.dart';
import 'package:url_launcher/url_launcher.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  //insert item into the table
  var db = new Mysql();
  var item_name = "";
  var item_desc = "";
  var item_SN = "";
  var amount = "";
  var ewtype_id = "";
  var img_url = "";
  var brand_id = "";

  final itemNameController = TextEditingController();
  final itemDetailsController = TextEditingController();
  final itemSNController = TextEditingController();
  final amountController = TextEditingController();
  final imgURLController = TextEditingController();
  String _selectedTypeValue = 'โทรศัพท์';
  String _selectedBrandValue = 'Other';

  //list for dropdown menu

  List<String> _dropdownTypeValue = [
    'โทรศัพท์',
    'สายชาร์จ',
    'แบตเตอรี่',
    'หัวชาร์จ',
    'หูฟัง',
    'การ์ดหน่วยความจำ',
    'พาวเวอร์แบงค์',
    'แท็บเล็ต'
  ];

  final List<String> _dropdownBrandValue = [
    'Apple',
    'Google',
    'OnePlus',
    'Oppo',
    'Huawei',
    'Realme',
    'Samsung',
    'Vivo',
    'Xiaomi',
    'Sony',
    'Motorola',
    'Nokia',
    'Kingston',
    'Other'
  ];

  void insertData() async {
    int selectedIndex = _dropdownTypeValue.indexOf(_selectedTypeValue);
    int selectedIndex2 = _dropdownBrandValue.indexOf(_selectedBrandValue);
    db.getConnection().then((conn) {
      String sqlQuery =
          'INSERT INTO `ewastedb`.`item` (`item_name`, `item_desc`, `amount`, `ewtype_id`, `brand_id` , `item_SN`, `img_url`) VALUES (?, ?, ?, ?, ?, ?,?)';
      //INSERT INTO `ewastedb`.`item` (`item_name`, `item_desc`, `amount`, `ewtype_id`, `item_SN`) VALUES ('test g', 'test g', '1', '5', '1234');
      conn.query(sqlQuery, [
        itemNameController.text,
        itemDetailsController.text,
        amountController.text,
        selectedIndex.toString(),
        selectedIndex2.toString(),
        // _selectedTypeValue,
        itemSNController.text,
        imgURLController.text
      ]);
      setState(() {});
      print("Data Added");
      print(itemNameController.text);
      print(itemDetailsController.text);
      print(amountController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    itemNameController.dispose();
    itemDetailsController.dispose();
    amountController.dispose();
    itemSNController.dispose();
    imgURLController.dispose();
  }

// // function to open Google.com in browser
//   void _launchURL() async {
//     const url = 'https://www.google.com';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มรายการขยะ"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          Text('ชื่อสินค้า'),
          TextFormField(
            controller: itemNameController,
            decoration: InputDecoration(
                hintText: "ชื่อสินค้า", border: OutlineInputBorder()),
          ),
          SizedBox(height: 15),
          Text('รายละเอียดสินค้า'),
          TextFormField(
            controller: itemDetailsController,
            decoration: const InputDecoration(
                hintText: "รายละเอียดสินค้า", border: OutlineInputBorder()),
          ),
          SizedBox(height: 15),
          Text('จำนวน 1 หน่วย'),
          TextFormField(
            controller: amountController,
            decoration: const InputDecoration(
                hintText: "จำนวน 1 หน่วย", border: OutlineInputBorder()),
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
          Text('ประเภทสินค้า'),
          SizedBox(
            width: 300,
            child: DropdownButtonFormField<String>(
              hint: Text('เลือกประเภทสินค้า'),
              value: _selectedTypeValue,
              items: _dropdownTypeValue.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTypeValue = newValue.toString();
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'โปรดเลือกประเภทขยะอิเล็กทรอนิกส์';
                }
                return null;
              },
            ),
            height: 50,
          ),
          const SizedBox(height: 15),
          Text('แบรนด์สินค้า'),
          SizedBox(
            width: 300,
            child: DropdownButtonFormField<String>(
              hint: Text('เลือกแบรนด์'),
              value: _selectedBrandValue,
              items: _dropdownBrandValue.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBrandValue = newValue.toString();
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'โปรดเลือกแบรนด์';
                }
                return null;
              },
            ),
            height: 50,
          ),
          SizedBox(height: 20),
          Text('หมายเลขเครื่อง'),
          TextFormField(
            controller: itemSNController,
            decoration: InputDecoration(
                hintText: "หมายเลขเครื่อง", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
              'กรุณากดปุ่ม ไอคอนรูปกล้อง เพื่ออัปโหลดรูปภาพลงเว็บไซต์ และ ตัดลอก URL มาวางในช่องด้านล่าง'),
          SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse("https://postimages.org/");
                await launchUrl(url);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Link',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          // Column(
          //   children: [
          //     ElevatedButton(
          //       child: Text("Link"),
          //       onPressed: () async {
          //         final Uri url = Uri.parse("https://twitter.com/home");
          //         launchUrl(url);
          //       },
          //     ),
          //   ],
          // ),

          Text('URL รูปภาพ'),
          TextFormField(
            controller: imgURLController,
            decoration: InputDecoration(
                hintText: "กรุณากดปุ่ม เพื่ออัปโหลดและคัดลอก URL รูปภาพ",
                border: OutlineInputBorder()),
          ),

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

// https://medium.com/@flutterqueen/how-to-send-and-show-data-from-the-flutter-app-to-mysql-database-without-php-or-rest-api-server-2c249b09bc04
//insert data http mulitpart imgfile and textediting controller or textfield 
//select * from table and show data
