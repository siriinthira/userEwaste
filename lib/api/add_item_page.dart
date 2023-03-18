import 'package:flutter/material.dart';
import 'package:user/api/http.dart';

class AddUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddUserPageState();
  }
}

class AddUserPageState extends State<AddUserPage> {
  TextEditingController nameController = TextEditingController();
  String response = "";

  createUser() async {
    var result = await http_post("create-user", {
      "name": nameController.text,
    });
    if (result.ok!) {
      setState(() {
        response = result.data['status'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Name"),
          ),
          ElevatedButton(
            onPressed: createUser,
            child: Text("Create"),
          ),
          Text(response),
        ],
      ),
    );
  }
}

// https://www.youtube.com/watch?v=h7oHwRzcZeo&t=102s

/*
 ElevatedButton(
            onPressed: createItem,
            child: Text("Create"),
          ),
           */