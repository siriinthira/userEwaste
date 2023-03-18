import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mysql1/mysql1.dart';

// class InsertData extends StatefulWidget {
//   const InsertData({super.key});

//   @override
//   State<InsertData> createState() => _InsertDataState();
// }

// class _InsertDataState extends State<InsertData> {

//   final db = MySql();
//   final productNameController = TextEditingController();
//   final productDetailsController = TextEditingController();

//   //method to insert data in mySQL
//   void insertData() async {
//     db.getConnection().then((conn){
//       String sqlQuery = 'insert into  '
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }

// }

class Mysql {
  static String host = 'utcccs.cj5octuotk3f.ap-northeast-1.rds.amazonaws.com',
      user = 'ewuser',
      password = 'ewuser123',
      db = 'ewastedb';

  static int port = 8080;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }
}
