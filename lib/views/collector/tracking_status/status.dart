import 'package:flutter/material.dart';
import 'package:user/models/data_model.dart';

class status extends StatefulWidget {
  const status({super.key});

  @override
  State<status> createState() => _statusState();
}

class _statusState extends State<status> {
  var db = new Mysql();
  List<Map<String, dynamic>> items = [];
  List<String> statusList = [];
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _getItem();
  }

  void _getItem() {
    db.getConnection().then((conn) {
      String sql =
          'SELECT * FROM item JOIN status ON status.status_code = item.status_code;';
      conn.query(sql).then((results) {
        List<Map<String, dynamic>> items = [];
        for (var row in results) {
          items.add({
            'id': row[0], // changed from 'name' to 'id'
            'name': row[11],
            'image_url': row[8],
            'status_code': row['status_code'],
          });
          if (!statusList.contains(row[11])) {
            statusList.add(row[11]);
          }
        }
        setState(() {
          this.items = items;
        });
      });
    });
  }

  List<Map<String, dynamic>> getFilteredItems() {
    if (selectedStatus != null && selectedStatus!.isNotEmpty) {
      return items.where((item) => item['name'] == selectedStatus).toList();
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ติดตามสถานะ'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedStatus,
            hint: Text('เลือกสถานะ'),
            items: statusList.map((String status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(status),
              );
            }).toList(),
            onChanged: (String? newStatus) {
              setState(() {
                selectedStatus = newStatus;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getFilteredItems().length,
              padding: EdgeInsets.all(5),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text('Item ID: ${getFilteredItems()[index]['id']}'),
                    subtitle: Text(
                        'Status name: ${getFilteredItems()[index]['name']}'),
                    leading: Image.network(
                      '${getFilteredItems()[index]['image_url']}',
                      width: 100,
                      height: 100,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}////อันที่ดีสุด
