import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllItemData extends StatefulWidget {
  @override
  _AllItemDataState createState() => _AllItemDataState();
}

class _AllItemDataState extends State<AllItemData> {
  Future allItem() async {
    var url = "http://192.168.1.101/image_upload_php_mysql/viewAll.php";
    // final url = Uri.parse("http://13.231.130.117:3000/requests/item");
 
    var response = await http.get(url as Uri);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    allItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item All Data'),
      ),
      body: FutureBuilder(
        future: allItem(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    return Card(
                      child: ListTile(
                        title: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            "http://192.168.1.101/image_upload_php_mysql/uploads/${list[index]['image']}",
                            // "http://13.231.130.117:3000/requests/item/${list[index]['image']}",
                          ),
                        ),
                        subtitle: Center(child: Text(list[index]['name'])),
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
