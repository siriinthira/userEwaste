import 'package:flutter/material.dart';
import 'package:user/models/item_model.dart';

class Details extends StatelessWidget {
  Details({Key? key, required this.itemDetails}) : super(key: key);

  // String productName, productDes;

  ItemDetails itemDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียด'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      // body: Center(
      //   child: Text("Detail Screen"),
      // ),
      body: Container(
        padding: EdgeInsets.all(4.0),
        child: ListView(
          children: [
            //Dynamic Tile
            ListTile(
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.0, color: Colors.grey.shade300)),
              leading: IconButton(
                icon: const Icon(Icons.shopping_bag_outlined,
                    color: Colors.grey, size: 50.0),
                onPressed: () {},
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // productDetails.checkBox == true
                  //     ? (const Chip(
                  //         label: Text("เกี่ยวกับสินค้า"),
                  //         backgroundColor: Colors.green,
                  //         labelStyle: TextStyle(color: Colors.white)))
                  //     : Text(""),
                  Chip(
                      label: Text("ขยะอิเล็กทรอนิกส์"),
                      backgroundColor: Colors.green,
                      labelStyle: TextStyle(color: Colors.white)),
                  Text(""),
                  Text(
                    itemDetails.item_name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('จำนวนรายการ (หน่วย):  '),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    itemDetails.item_desc,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text(
                          itemDetails.ewtype_id as String,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //Previous Tile
      // ListTile(
      //   leading: Icon(Icons.phone_android),
      //   title: Text('productName'),
      // ),
      // ListTile(
      //   leading: Icon(Icons.description),
      //   title: Text('productDes'),
      // ),
      // ListTile(
      //   leading: Icon(Icons.format_list_numbered),
      //   title: Text(amount),
      // )
    );
  }
}

// class ProductDetails {}

  // Details({Key? key, required this.productName, required this.productDes})
  //     : super(key: key);
  // Details(
  //     {Key? key,
  //     required this.productDetails,
  //     required this.productName,
  //     required this.productDes,
  //     required this.amount,
  //     required this.productType})
  //     : super(key: key);
