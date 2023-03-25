// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AllItem extends StatefulWidget {
//   @override
//   _AllItemState createState() => _AllItemState();
// }

// class _AllItemState extends State<AllItem> {
//   Future getPerson() async {
//     var url = 'http://13.231.130.117:3000/requests/item';
//     var response = await http.get(url as Uri);
//     return json.decode(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Php Mysql Crud Using Flutter'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {},
//       ),
//       body: FutureBuilder(
//         future: getPerson(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) print(snapshot.error);
//           return snapshot.hasData
//               ? ListView.builder(
//                   itemCount:
//                       snapshot.data.length == null ? 0 : snapshot.data.length,
//                   itemBuilder: (context, index) {
//                     List list = snapshot.data;
//                     return Card(
//                       elevation: 3,
//                       child: ListTile(
//                         title: Container(
//                           width: 100,
//                           height: 100,
//                           child: Image.network(
//                               "http://192.168.1.101/image_upload_php_mysql/uploads/${list[index]['image']}"
//                               // " http://13.231.130.117:3000/requests/item/${list[index]['image']}"),
//                         ),
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(list[index]['name']),
//                           ),
//                         ),
//                       ),
//                      ), );
//                   })
//               : Center(
//                   child: CircularProgressIndicator(),
//                 );
//         },
//       ),
//     );
//   }
// }
