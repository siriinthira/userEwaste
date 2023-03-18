import 'dart:ui';
import 'dart:io';
import 'package:flutter/painting.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:user/views/details.dart';
import 'package:user/models/item_model.dart';
import 'package:user/widgets/my_button.dart';
import 'package:user/widgets/my_radio_button.dart';
import 'package:get/get.dart';
import '../controller/itemController.dart';
// import 'package:user/my_text_field.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  _MyFormState() {
    _dropdownselectedVal = _productTypeList[0];
  }

  //data members
  var _productName, _productDes, _amount, _id;

  String? _dropdownselectedVal = "";
  final _productController = TextEditingController();
  final _productDesController = TextEditingController();
  final _amountController = TextEditingController();
  final _idController = TextEditingController();

  //bool? _checkBoxValue = false;
  bool? _ListTileCheckBox = false;
  ProductTypeEnum? _productTypeRadioButton;

  final _productTypeList = [
    "โทรศัพท์เคลื่อนที่",
    "แบตเตอรี่",
    "หัวชาร์จ",
    "สายชาร์จ",
    "แท็บเล็ต",
    "พาวเวอร์แบงค์",
    "หูฟัง",
    "แฟลชไดรฟ์",
    "การ์ดหน่วยความจำ"
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _updateText();
  }

  void _updateText() {
    setState(() {
      _productController.clear();
      _productDesController.clear();
      _amountController.clear();
      _idController.clear();
    });
  }

  File? _image;

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() {
        this._image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  Future getImage2(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    //final imageTemporary = File(image.path);
    final imagePermanent = await saveFilePermanently(image.path);

    setState(() {
      this._image = imagePermanent;
    });
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  //UI Display
  @override
  Widget build(BuildContext context) {
    final ItemController c = Get.put(ItemController());

    return Scaffold(
      appBar: AppBar(
          title: const Text("แบบฟอร์มเพิ่มรายการขยะ"), centerTitle: true),
      body: Container(
        // child: myBtn(context),
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            _image != null
                ? Image.file(
                    _image!,
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSalEj8tnk7AywBgsPErBHh2_8vFwc2yZty-mqmzy3t6pP_lN3WnokkH8ghoeFPZ13cs3g&usqp=CAU'),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomButton(
                    title: ' Gallery',
                    icon: Icons.image_outlined,
                    onClick: () => getImage(ImageSource.gallery),
                  ),
                  CustomButton(
                    title: ' Camera',
                    icon: Icons.camera,
                    onClick: () => getImage2(ImageSource.camera),
                  ),
                ],
              ),
            ),
            // const Image(
            //   image: AssetImage('images/ecobag.png'),
            //   height: 150,
            //   width: 150,
            // ),
            // const Text("ข้อมูลขยะอิเล็กทรอนิกส์"),
            // const Text("กรอกรายละเอียดเกี่ยวกับขยะอิเล็กทรอนิกส์ของคุณ"),
            const SizedBox(
              height: 20,
            ),

            /* ------ Form ----- */

            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextField(
                    fieldName: "รหัสสินค้า",
                    myController: _idController,
                    myIcon: Icons.format_list_numbered,
                    prefixIconColor: Colors.lightGreen.shade700,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  MyTextField(
                    fieldName: "ชื่อผลิตภัณฑ์",
                    myController: _productController,
                    myIcon: Icons.phone_android,
                    prefixIconColor: Colors.lightGreen.shade700,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  MyTextField(
                    fieldName: "รายละเอียด",
                    myController: _productDesController,
                    myIcon: Icons.description,
                    prefixIconColor: Colors.lightGreen.shade700,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  MyTextField(
                    fieldName: "จำนวน",
                    myController: _amountController,
                    myIcon: Icons.format_list_numbered,
                    prefixIconColor: Colors.lightGreen.shade700,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //DropDown Menu
                  Text(
                    "เลือกประเภทรายการขยะ",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField<String>(
                    value: _dropdownselectedVal,
                    icon: const Icon(
                      Icons.flutter_dash,
                      color: Colors.green,
                    ),
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                        labelText: "ประเภทขยะอิเล็กทรอนิกส์ของคุณ",
                        prefixIcon:
                            Icon(Icons.accessibility_new, color: Colors.green),
                        border: UnderlineInputBorder()),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        _dropdownselectedVal = value!;
                      });
                    },
                    items: _productTypeList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20.0),

                  MyButton(onPress: () {
                    _productName = _productController.text;
                    _productDes = _productDesController.text;
                    _amount = _amountController.text;
                    _id = _idController.text;
                    _updateText();

                    var product = ItemDetails(
                        item_id: int.parse(_id),
                        item_name: _productName,
                        item_desc: _productDes,
                        amount: int.parse(_amount),
                        ewtype_id: _dropdownselectedVal!);
                    c.addItem(product);

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('บันทึกรายการขยะใหม่'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(_id),
                                Text(_productName),
                                Text(_productDes),
                                Text(_dropdownselectedVal!),
                                Text(_amount),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} //class _MyFormState

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
    this.keyboardType = TextInputType.phone,
  }) : super(key: key);

  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;
  final keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'กรุณากรอกข้อมูลให้ครบถ้วน';
        } else
          ' ';
      },
      controller: myController,
      decoration: InputDecoration(
          labelText: fieldName,
          prefixIcon: Icon(myIcon, color: prefixIconColor),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightGreen),
          ),
          labelStyle: const TextStyle(color: Colors.black54)),
    );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 35,
        child: ElevatedButton(
          onPressed: onClick,
          child: Row(
            children: [Icon(icon), Text(title)],
          ),
        ),
      ),
    ),
  );
}


/*

            //1 CheckBox
            // Checkbox(
            //   checkColor: Colors.white,
            //   activeColor: Colors.green,
            //   value: _checkBoxValue,
            //   onChanged: (bool? newValue) {
            //     setState(() {
            //       _checkBoxValue = newValue;
            //     });
            //   },
            // ),

 */

