import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class sendItem extends StatefulWidget {
  const sendItem({super.key});

  @override
  State<sendItem> createState() => _sendItemState();
}

class _sendItemState extends State<sendItem> {
  @override
  Widget build(BuildContext context) {
    var key;
    return Scaffold(
        appBar: AppBar(
          title: Text("send Item"),
        ),
        body: Form(
            key: key,
            child: Column(
              children: [
                TextFormField(),
                TextFormField(),
                IconButton(onPressed: () {}, icon: Icon(Icons.abc))
              ],
            )));
  }
}

/*
Pick or capture image using image_picker
Upload the image to Firebase storage
Get the URL of the uploaded image
Store the image URL inside the corresponding document in database

 */


//https://www.youtube.com/watch?v=nEcb3ieAICs
//https://www.youtube.com/watch?v=c2tGUt7FLqY
//https://www.youtube.com/watch?v=7XOQAtSTw4s
// https://www.youtube.com/watch?v=g8WEXj6xvsY
/*

http method = post
enctype = multiport / form data
 */
