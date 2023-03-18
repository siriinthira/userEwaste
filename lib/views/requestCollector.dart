import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysql1/mysql1.dart';
// import 'models/mysql.dart';
import 'dart:ui';

import 'package:user/models/item_model.dart';

class requestCollector extends StatefulWidget {
  const requestCollector({super.key});

  @override
  State<requestCollector> createState() => _requestCollectorState();
}

class _requestCollectorState extends State<requestCollector> {
  //insert item to the table

  //select item from the table
  var db = new Mysql();
  var item_name = "";
  var item_desc = "";
  var amount;

  void _getItem() {
    db.getConnection().then((conn) {
      String sql =
          'SELECT item_name, item_desc, amount FROM ewastedb.item WHERE item_id = 5';

      // 'SELECT * FROM ewastedb.item ';
      conn.query(sql).then((results) {
        for (var row in results) {
          print(row);
          setState(() {
            item_name = row[0];
            item_desc = row[1];
            amount = row[2];
          });
        }
      });
    });
  }

  final itemNameController = TextEditingController();
  final ItemDetailsController = TextEditingController();

  void insertData() async {
    db.getConnection().then((conn) {
      String sqlQuery =
          'INSERT INTO `ewastedb`.`item` (`item_name`, `item_desc`) VALUES (?, ?)'; //INSERT INTO `ewastedb`.`item` (`item_name`, `item_desc`, `amount`, `req_id`, `ewtype_id`) VALUES ('item4', 'my itemm desc', '', '', '');
      conn.query(
          sqlQuery, [itemNameController.text, ItemDetailsController.text]);
      setState(() {});
      print("Data Added");
    });
  }

  @override
  void dispose() {
    super.dispose();
    itemNameController.dispose();
    ItemDetailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("request Collector"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'item name: ',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              '${item_name}',
              style: TextStyle(fontSize: 39, fontWeight: FontWeight.bold),
            ),
            Text(
              'desc:',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              '${item_desc}',
              style: TextStyle(fontSize: 39, fontWeight: FontWeight.bold),
            ),
            Text(
              'amount',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              '$amount',
              style: TextStyle(fontSize: 39, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'คลิกเพื่อดูรายการขยะ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: _getItem,
        tooltip: 'get data',
        //child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("request Collector"),
  //     ),
  //     body: ListView(
  //       padding: const EdgeInsets.all(30),
  //       children: [
  //         TextField(
  //           controller: itemNameController,
  //           decoration: const InputDecoration(hintText: "item name"),
  //         ),
  //         TextField(
  //           controller: ItemDetailsController,
  //           decoration: const InputDecoration(hintText: "item details"),
  //         ),
  //         const SizedBox(
  //           height: 50,
  //         ),
  //         TextButton(
  //             onPressed: () {
  //               insertData();
  //               print('Data inserted successfully!');
  //             },
  //             child: const Text('Insert data'))
  //       ],
  //     ),
  //   );
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
