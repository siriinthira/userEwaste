import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:user/models/data_model.dart';
import 'package:user/views/collector/receive_task_from_user/receive_task_from_user.dart';

class viewRequest extends StatefulWidget {
  const viewRequest({super.key});

  @override
  State<viewRequest> createState() => _viewRequestState();
}

class _viewRequestState extends State<viewRequest> {
  int _counter = 0;
  var db = new Mysql();
  var item = [];
  var ewaste_type = [];
  var request = [];
  @override
  void initState() {
    super.initState();
    _getItem();
  }

  void _getItem() {
    db.getConnection().then((conn) {
      String sql =
          'SELECT * FROM item JOIN request ON item.req_id = request.req_id';
      conn.query(sql).then((results) {
        setState(() {
          item = results.toList();
          request = results.toList();
        });
      });
    });
  }

  void _calculateDistance() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('คำขอส่งขยะจากผู้ใช้'),
      ),
      body: ListView.builder(
        itemCount: item.length,
        padding: EdgeInsets.all(5),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Column(
                children: [
                  Text('รหัสสินค้า: ${item[index][0]}'),
                  Text('ชื่อสินค้า: ${item[index][1]}'),
                  Text('จำนวน: ${item[index][3]}'),
                  Text('ละติจูด: ${item[index][12]} '),
                  Text('ลองจิจูด: ${item[index][13]} '),
                  Text('เขต: ${item[index][14]} '),
                ],
              ),
              // subtitle: Text('Item name: ${item[index][1]}'),
              leading: Image.network(
                '${item[index][8]}',
                width: 100,
                height: 100,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => receiveTask()));
        },
        label: const Text('คลิกหน้าถัดไป'),
        icon: const Icon(Icons.skip_next_outlined),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
