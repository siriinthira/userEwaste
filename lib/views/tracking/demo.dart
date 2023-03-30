import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/foundation.dart';
import 'package:user/models/data_model.dart';

import 'package:mysql1/mysql1.dart';

class DropdownDemo2 extends StatefulWidget {
  const DropdownDemo2({Key? key}) : super(key: key);
  @override
  State<DropdownDemo2> createState() => _DropdownDemo2State();
}

class _DropdownDemo2State extends State<DropdownDemo2> {
  // Step 1.
  late Future<List<Map<String, dynamic>>> _dataFuture;
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _dataFuture = getDataFromDatabase();
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
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _dataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final data = snapshot.data!;
                  return DropdownButton<String>(
                    // Step 3.
                    value: _selectedValue,
                    // Step 4.
                    // width: 200, // Set the width here
                    items: data.map<DropdownMenuItem<String>>((row) {
                      final agentId = row['agent_id'];
                      final timestamp = row['rp_timestamp'];
                      final statusCode = row['status_code'];
                      final lat = row['rp_lat'];
                      final lng = row['rp_lng'];

                      return DropdownMenuItem<String>(
                        value:
                            '$agentId - $timestamp - $statusCode - $lat - $lng',
                        child: Text(
                          '$agentId - $timestamp - $statusCode - $lat - $lng',
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                    },
                  );
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Selected Value: $_selectedValue',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(),
  //     body: Center(
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: 50,
  //           ),
  //           // Step 2.
  //           FutureBuilder<List<Map<String, dynamic>>>(
  //             future: _dataFuture,
  //             builder: (context, snapshot) {
  //               if (snapshot.connectionState == ConnectionState.waiting) {
  //                 return CircularProgressIndicator();
  //               } else if (snapshot.hasError) {
  //                 return Text('Error: ${snapshot.error}');
  //               } else {
  //                 final data = snapshot.data!;
  //                 return DropdownButton<String>(
  //                   // Step 3.
  //                   value: _selectedValue,
  //                   // Step 4.
  //                   items: data.map<DropdownMenuItem<String>>((row) {
  //                     final agentId = row['agent_id'];
  //                     final timestamp = row['rp_timestamp'];
  //                     final statusCode = row['status_code'];
  //                     final lat = row['rp_lat'];
  //                     final lng = row['rp_lng'];

  //                     return DropdownMenuItem<String>(
  //                       value:
  //                           '$agentId - $timestamp - $statusCode - $lat - $lng',
  //                       child: Text(
  //                         '$agentId - $timestamp - $statusCode - $lat - $lng',
  //                         style: TextStyle(fontSize: 14),
  //                       ),
  //                     );
  //                   }).toList(),
  //                   // Step 5.
  //                   onChanged: (String? newValue) {
  //                     setState(() {
  //                       _selectedValue = newValue;
  //                     });
  //                   },
  //                 );
  //               }
  //             },
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Text(
  //             'Selected Value: $_selectedValue',
  //             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<List<Map<String, dynamic>>> getDataFromDatabase() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'utcccs.cj5octuotk3f.ap-northeast-1.rds.amazonaws.com',
        port: 3306,
        user: 'ewuser',
        password: 'ewuser123',
        db: 'ewastedb'));

    final results = await conn.query(
        'SELECT agent_id, rp_timestamp, status_code, rp_lat, rp_lng FROM request_process');

    await conn.close();
    return results.map((row) => row.fields).toList();
  }
}
