import 'package:flutter/material.dart';
import 'package:user/api/http.dart';
import 'package:user/api/add_item_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class User {
  String id;
  String name;
  User(this.id, this.name);
}

class MainPageState extends State<MainPage> {
  List<User> users = [];
  Future<void> refreshUsers() async {
    var result = await http_get('users');
    if (result.ok!) {
      setState(() {
        users.clear();
        var in_users = result.data as List<dynamic>;
        in_users.forEach((in_user) {
          users.add(User(in_user['id'].toString(), in_user['name']));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddUserPage();
              }));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshUsers,
        child: ListView.separated(
          itemCount: users.length,
          itemBuilder: (context, i) => ListTile(
            leading: Icon(Icons.person),
            title: Text(users[i].name),
          ),
          separatorBuilder: (context, i) => Divider(),
        ),
      ),
    );
  }
}


// https://github.com/aameen951/flutter_nodejs
//  https://www.youtube.com/watch?v=h7oHwRzcZeo&t=102s