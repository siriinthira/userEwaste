import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user/sourcecode/Frontend/details.dart';
import 'package:user/sourcecode/Frontend/form.dart';

// additem --> form --> detail

class addItem extends StatefulWidget {
  const addItem({super.key});

  @override
  State<addItem> createState() => _addItemState();
}

class _addItemState extends State<addItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มรายการขยะอิเล็กทรอนิกส์"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            //
            const SizedBox(
              height: 5,
            ),
            const Image(
              image: AssetImage('images/zero_carbon_together.png'),
              height: 500,
              width: 500,
            ),

            Center(
              child: OutlinedButton(
                style:
                    OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
                onPressed: () {
                  //...?
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyForm();
                      },
                    ),
                  );
                },
                child: Text(
                  "คลิกเพื่อเพิ่มรายการขยะ".toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      // Center(
      //   child: OutlinedButton(
      //     style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      //     onPressed: () {
      //       //...?
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) {
      //             return MyForm();
      //           },
      //         ),
      //       );
      //     },
      //     child: Text(
      //       "คลิกเพื่อเพิ่มรายการขยะ".toUpperCase(),
      //       style: const TextStyle(fontWeight: FontWeight.bold),
      //     ),
      //   ),
      // ),
    );
  }
}

//ui add textfields
//brand name
//serial no
//delete amount