// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// // import 'package:multipart_request/multipart_request.dart';

// class DemoUploadImage extends StatefulWidget {
//   const DemoUploadImage({super.key});

//   @override
//   State<DemoUploadImage> createState() => _DemoUploadImageState();
// }

// class _DemoUploadImageState extends State<DemoUploadImage> {
//   late File _image = File('your initial file');
//   final picker = ImagePicker();
//   TextEditingController item_nameController = TextEditingController();
//   TextEditingController item_descController = TextEditingController();
//   TextEditingController amountController = TextEditingController();
//   TextEditingController ewtype_idController = TextEditingController();

//   Future choiceImage() async {
//     var pickedImage = await picker.getImage(source: ImageSource.gallery);
//     setState(() {
//       _image = File(pickedImage!.path);
//     });
//   }

//   Future uploadImage() async {
//     final uri = Uri.parse("...");
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['item_name'] = item_nameController.text;
//     request.fields['item_desc'] = item_descController.text;
//     request.fields['amount'] = amountController.text;
//     request.fields['ewtype_id'] = ewtype_idController.text;
//     var pic = await http.MultipartFile.fromPath("image", _image.path);
//     request.files.add(pic);
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       print('Image uploaded');
//     } else {
//       print('Image not uploaded');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Upload Image"),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: item_nameController,
//                   decoration: InputDecoration(labelText: 'item name'),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   child: TextField(
//                     controller: item_descController,
//                     decoration: InputDecoration(labelText: 'item desc'),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   child: TextField(
//                     controller: amountController,
//                     decoration: InputDecoration(labelText: 'amount'),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   child: TextField(
//                     controller: ewtype_idController,
//                     decoration: InputDecoration(labelText: 'type'),
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.camera_alt_outlined),
//                 onPressed: () {
//                   choiceImage();
//                 },
//               ),
//               Container(
//                 child: _image == null
//                     ? Text('No Image Selected')
//                     : Image.file(_image),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   uploadImage();
//                 },
//                 child: Text('Upload Image'),
//               )
//             ],
//           ),
//         ));
//   }
// }
