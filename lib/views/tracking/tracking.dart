import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/foundation.dart';
import 'package:user/models/data_model.dart';

import 'package:mysql1/mysql1.dart';

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({Key? key}) : super(key: key);
  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String dropdownValue = 'item1';
  List<Map<String, dynamic>> data = []; // initialize empty list

  Future<List<Map<String, dynamic>>> getDataFromDatabase(
      String selectedItem) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'utcccs.cj5octuotk3f.ap-northeast-1.rds.amazonaws.com',
        port: 3306,
        user: 'ewuser',
        password: 'ewuser123',
        db: 'ewastedb'));

    final results = await conn.query(
        'SELECT agent_id, rp_timestamp, status_code, rp_lat, rp_lng FROM request_process WHERE item=?',
        [selectedItem]);

    await conn.close();
    return results.map((row) => row.fields).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            // Step 2.
            DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>['item1', 'item2', 'item3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) async {
                final List<Map<String, dynamic>> result =
                    await getDataFromDatabase(newValue!);
                setState(() {
                  dropdownValue = newValue;
                  data = result;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Selected Value: $dropdownValue',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            // show table of retrieved data
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Agent ID')),
                  DataColumn(label: Text('Timestamp')),
                  DataColumn(label: Text('Status Code')),
                  DataColumn(label: Text('Latitude')),
                  DataColumn(label: Text('Longitude')),
                ],
                rows: data
                    .map((row) => DataRow(cells: [
                          DataCell(Text(row['agent_id'].toString())),
                          DataCell(Text(row['rp_timestamp'].toString())),
                          DataCell(Text(row['status_code'].toString())),
                          DataCell(Text(row['rp_lat'].toString())),
                          DataCell(Text(row['rp_lng'].toString())),
                        ]))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class DropdownDemo extends StatefulWidget {
//   const DropdownDemo({Key? key}) : super(key: key);
//   @override
//   State<DropdownDemo> createState() => _DropdownDemoState();
// }

// class _DropdownDemoState extends State<DropdownDemo> {
//   // Step 1.
//   late Future<List<Map<String, dynamic>>> _dataFuture;
//   String? _selectedValue;

//   @override
//   void initState() {
//     super.initState();
//     _dataFuture = getDataFromDatabase();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             // Step 2.
//             FutureBuilder<List<Map<String, dynamic>>>(
//               future: _dataFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   final data = snapshot.data!;
//                   return DropdownButton<String>(
//                     // Step 3.
//                     value: _selectedValue,
//                     // Step 4.
//                     items: data.map<DropdownMenuItem<String>>((row) {
//                       final agentId = row['agent_id'];
//                       final timestamp = row['rp_timestamp'];
//                       final statusCode = row['status_code'];
//                       final lat = row['rp_lat'];
//                       final lng = row['rp_lng'];

//                       return DropdownMenuItem<String>(
//                         value:
//                             '$agentId - $timestamp - $statusCode - $lat - $lng',
//                         child: Text(
//                           '$agentId - $timestamp - $statusCode - $lat - $lng',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                       );
//                     }).toList(),
//                     // Step 5.
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedValue = newValue;
//                       });
//                     },
//                   );
//                 }
//               },
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               'Selected Value: $_selectedValue',
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<List<Map<String, dynamic>>> getDataFromDatabase() async {
//     final conn = await MySqlConnection.connect(ConnectionSettings(
//         host: 'utcccs.cj5octuotk3f.ap-northeast-1.rds.amazonaws.com',
//         port: 3306,
//         user: 'ewuser',
//         password: 'ewuser123',
//         db: 'ewastedb'));

//     final results = await conn.query(
//         'SELECT agent_id, rp_timestamp, status_code, rp_lat, rp_lng FROM request_process');

//     await conn.close();
//     return results.map((row) => row.fields).toList();
//   }
// }









// class DropdownDemo extends StatefulWidget {
//   const DropdownDemo({Key? key}) : super(key: key);
//   @override
//   State<DropdownDemo> createState() => _DropdownDemoState();
// }

// class _DropdownDemoState extends State<DropdownDemo> {
//   String dropdownValue = 'Dog';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             // Step 2.
//             DropdownButton<String>(
//               // Step 3.
//               value: dropdownValue,
//               // Step 4.
//               items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(
//                     value,
//                     style: TextStyle(fontSize: 30),
//                   ),
//                 );
//               }).toList(),
//               // Step 5.
//               onChanged: (String? newValue) {
//                 setState(() {
//                   dropdownValue = newValue!;
//                 });
//               },
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               'Selected Value: $dropdownValue',
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }














// class tracking extends StatefulWidget {
//   const tracking({super.key});

//   @override
//   State<tracking> createState() => _trackingState();
// }

// class _trackingState extends State<tracking> {


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ติดตามสถานะการขนส่ง'),
//       ),
//       body: Center(),
//     );
//   }
// }
















// Widget to display the timeline
// class TimelineWidget extends StatelessWidget {
//   final List<Map<String, dynamic>> data;

//   const TimelineWidget({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: data.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           leading: Icon(Icons.timeline),
//           title: Text(data[index]['status_code']),
//           subtitle: Text(data[index]['rp_timestamp']),
//         );
//       },
//     );
//   }
// }



// // Widget to display the dropdown menu
// class DropdownWidget extends StatefulWidget {
//   const DropdownWidget({Key? key}) : super(key: key);

//   @override
//   _DropdownWidgetState createState() => _DropdownWidgetState();
// }

// class _DropdownWidgetState extends State<DropdownWidget> {
//   String? selectedItem;
//   List<String> items = ['item_id_1', 'item_id_2', 'item_id_3'];

// // Function to retrieve data from MySQL database
//   Future<List<Map<String, dynamic>>> getDataFromDatabase(
//       String selectedValue) async {
//     final conn = await MySqlConnection.connect(ConnectionSettings(
//         host: 'utcccs.cj5octuotk3f.ap-northeast-1.rds.amazonaws.com',
//         port: 3306,
//         user: 'your_username',
//         password: 'your_password',
//         db: 'ewastedb'));

//     // Retrieve data from the database based on the selected value
//     final results = await conn.query(
//         'SELECT agent_id, rp_timestamp, status_code, rp_lat, rp_lng FROM request_process WHERE item_id = ?',
//         [selectedValue]);

//     await conn.close();
//     return results.map((row) => row.fields).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         DropdownButton<String>(
//           value: selectedItem,
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (String? newValue) async {
//             // Call the function to retrieve data from the database based on the selected value
//             final data = await getDataFromDatabase(newValue!);

//             // Display the retrieved data in a timeline format
//             Navigator.of(context).push(
//                 MaterialPageRoute(builder: (_) => TimelineWidget(data: data)));
//             setState(() {
//               selectedItem = newValue;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
