import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadDataPage extends StatefulWidget {
  @override
  _UploadDataPageState createState() => _UploadDataPageState();
}

class _UploadDataPageState extends State<UploadDataPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController SNController = TextEditingController();

  String? _selectedValue;
  String? _selectedBrand;
  List<String> _dropdownValues = [
    'โทรศัพท์',
    'สายชาร์จ',
    'แบตเตอรี่',
    'หัวชาร์จ',
    'หูฟัง',
    'การ์ดหน่วยความจำ',
    'พาวเวอร์แบงค์',
    'แท็บเล็ต'
  ];
  List<String> _dropdownBrands = [
    'iPhone',
    'Samsung',
    'Huawei',
    'Sony',
  ];

  File? _imageFile;

  void _selectImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  void _submitData() async {
    var url = Uri.https('13.231.130.117:3000', '/requests/item');
    var response = await http.post(url, body: {
      'item_name': itemNameController.text,
      'item_desc': itemDescController.text,
      'amount': amountController.text,
      'item_SN': SNController.text,
      'ewtype_id': _selectedValue,
      'brand_id': _selectedBrand
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  // void _submitData() async {
  //   if (_formKey.currentState!.validate()) {
  //     final url = Uri.parse('http://13.231.130.117:3000/requests/item');
  //     final request = http.MultipartRequest('POST', url);

  //     // Add text field data
  //     request.fields['item_name'] = itemNameController.text;
  //     request.fields['item_desc'] = itemDescController.text;
  //     request.fields['amount'] = amountController.text;
  //     request.fields['item_SN'] = SNController.text;

  //     // Add dropdown menu data
  //     request.fields['ewtype_id'] = _selectedValue!;
  //     request.fields['brand_id'] = _selectedBrand!;

  //     // Add image data
  //     if (_imageFile != null) {
  //       final imageFile =
  //           await http.MultipartFile.fromPath('image', _imageFile!.path);
  //       request.files.add(imageFile);
  //     }

  //     // Send the request
  //     final response = await request.send();
  //     if (response.statusCode == 200) {
  //       // Success
  //       print('Data inserted successfully!');
  //     } else {
  //       // Error
  //       print('Error inserting data.');
  //     }
  //   }

  //   setState(() {
  //     itemNameController.clear();
  //     itemDescController.clear();
  //     _imageFile = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Data Example'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: _imageFile != null
                      ? Image.file(_imageFile!)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                Icons.camera_alt_sharp,
                                size: 50,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('กรุณากดปุ่มเพื่อเลือกรูปภาพ')
                            ]),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _selectImage,
                  child: Text('Select Image'),
                ),
                SizedBox(
                  height: 25,
                ),
                Text('สามารถเพิ่มได้ครั้งละ 1 รายการเท่านั้น',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: itemNameController,
                    decoration: InputDecoration(
                      labelText: 'ชื่อสินค้า',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'โปรดกรอกชื่อสินค้า';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: itemDescController,
                    decoration: InputDecoration(
                      labelText: 'รายละเอียด',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกรายละเอียด';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'จำนวนสินค้า (สามารถเพิ่มครั้งละ 1 รายการ )',
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade300),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'โปรดระบุจำนวนสินค้า = 1';
                      } else if (int.parse(value) != 1 ||
                          int.parse(value) != 1) {
                        return "สามารถเพิ่มสินค้าได้ครั้งละหนึ่งรายการ";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: SNController,
                    decoration: InputDecoration(
                      labelText: 'หมายเลขสินค้า',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'โปรดระบุหมายเลขสินค้า';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField(
                    hint: Text('เลือกประเภทสินค้า'),
                    value: _selectedValue,
                    items: _dropdownValues.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedValue = newValue.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'โปรดเลือกประเภทขยะอิเล็กทรอนิกส์';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 25),

                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField(
                    hint: Text('เลือกแบรนด์'),
                    value: _selectedBrand,
                    items: _dropdownBrands.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedBrand = newValue.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'โปรดเลือกแบรนด์';
                      }
                      return null;
                    },
                  ),
                ),

                // Text(' 1 โทรศัพท์     2 หัวชาร์จ     3 สายชาร์จ'),
                // SizedBox(
                //   height: 5,
                // ),
                // Text(
                //     '    4 มือถือ     5 แท็บเล็ต     6 พาวเวอร์แบงค์     7 หูฟัง  '),
                // SizedBox(
                //   height: 5,
                // ),
                // Text('  8 แฟลชไดรฟ์     9 การ์ดหน่วยความจำ     10 เครื่องชาร์จ'),
                // SizedBox(
                //   height: 20,
                // ),
                // TextFormField(
                //   keyboardType: TextInputType.number,
                //   controller: typeController,
                //   decoration: InputDecoration(
                //     labelText: 'ประเภทสินค้า',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(35.0),
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'โปรดระบุชนิดของสินค้าตามหมายเลข';
                //     } else if (value.length > 1) {
                //       return "โปรดระบุหมายเลขเพียง 1 รายการ";
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: _submitData,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
Write Dart code for flutter app that uses http post multiport to insert data from textfield and image picker into database url
 */