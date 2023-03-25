// import 'dart:io';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mysql1/mysql1.dart';

// class InsertImageScreen extends StatefulWidget {
//   @override
//   _InsertImageScreenState createState() => _InsertImageScreenState();
// }

// class _InsertImageScreenState extends State<InsertImageScreen> {
//   final picker = ImagePicker();
//   File? _imageFile;

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _insertImage() async {
//     if (_imageFile != null) {
//       // Connect to MySQL database
//       final conn = await MySqlConnection.connect(ConnectionSettings(
//         host: 'utcccs.cj5octuotk3f.ap-northeast-1.rds.amazonaws.com',
//         port: 3306,
//         user: 'ewuser',
//         password: 'ewuser123',
//         db: 'ewastedb',
//       ));

//       final bytes = await _imageFile!.readAsBytes();
//       final imageData = Uint8List.fromList(bytes);

//       final result = await conn.query(
//         'INSERT INTO item (images) VALUES (?)',
//         [imageData],
//       );

//       if (result.affectedRows == 1) {
//         print('Image inserted successfully.');
//       } else {
//         print('Failed to insert image.');
//       }

//       await conn.close();
//     } else {
//       print('No image selected.');
//     }
//     //   final bytes = await _imageFile!.readAsBytes();
//     //   final base64Image = base64Encode(bytes);

//     //   final result = await conn.query(
//     //     'INSERT INTO ewastedb.item (images) VALUES (?)',
//     //     [Uint8List.fromList(base64.decode(base64Image))],
//     //   );

//     //   if (result.affectedRows == 1) {
//     //     print('Image inserted successfully.');
//     //   } else {
//     //     print('Failed to insert image.');
//     //   }

//     //   await conn.close();
//     // } else {
//     //   print('No image selected.');
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Insert Image Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile == null
//                 ? Text('No image selected.')
//                 : Image.file(
//                     _imageFile!,
//                     width: 300,
//                     height: 300,
//                   ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => _pickImage(ImageSource.camera),
//               child: Text('Pick from Camera'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => _pickImage(ImageSource.gallery),
//               child: Text('Pick from Gallery'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _insertImage,
//               child: Text('Insert Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
