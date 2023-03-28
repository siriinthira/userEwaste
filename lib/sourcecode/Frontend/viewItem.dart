import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../controller/itemController.dart';
import 'package:user/sourcecode/Frontend/form.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class viewItem extends StatefulWidget {
  const viewItem({super.key});

  @override
  State<viewItem> createState() => _viewItemState();
}

class _viewItemState extends State<viewItem> {
  @override
  Widget build(BuildContext context) {
// Instantiate your class using Get.put() to make it available for all "child" routes there.
    final ItemController c = Get.put(ItemController());

    return Scaffold(
      appBar: AppBar(
        title: Text("ดูรายการขยะ"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Slidable(
                key: ValueKey(0),
                endActionPane: ActionPane(
                  motion: DrawerMotion(),
                  children: [
                    // SlidableAction(
                    //   // An action can be bigger than the others.
                    //   // flex: 2,
                    //   onPressed: (context) {
                    //     c.updateItem(c.product[index].item_id);

                    //     setState(() {});
                    //   },
                    //   backgroundColor: Color.fromARGB(255, 219, 197, 61),
                    //   foregroundColor: Colors.white,
                    //   icon: Icons.edit,
                    //   label: 'Edit',
                    // ),
                    SlidableAction(
                      onPressed: (context) {
                        c.removeItem(c.product[index].item_id);
                        c.product.refresh();

                        setState(() {
                          //
                        });
                      },
                      backgroundColor: Color.fromARGB(255, 192, 64, 32),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Card(
                  color: Colors.grey.shade100,
                  elevation: 3,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.green.shade700,
                    onTap: () {},
                    child: SizedBox(
                      width: double.infinity,
                      height: 120,
                      child: Column(
                        children: [
                          Text(c.product[index].item_id.toString()),
                          Text(c.product[index].item_name),
                          Text(c.product[index].item_desc),
                          Text(c.product[index].ewtype_id),
                          Text("จำนวน"),
                          Text(c.product[index].amount.toString()),
                          // ElevatedButton.icon(
                          //   onPressed: () {
                          //     c.product[index] = TextEditingController();
                          //   },
                          //   icon: Icon(Icons.edit),
                          //   label: Text('Buttpn'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
            // return Dismissible(
            //   onDismissed: (direction) {
            //     //
            //     c.removeItem(index);
            //   },
            //   key: ValueKey<int>(index),
            // child: Card(
            //   clipBehavior: Clip.hardEdge,
            //   child: InkWell(
            //     splashColor: Colors.green.shade700,
            //     onTap: () {},
            //     child: SizedBox(
            //       width: double.infinity,
            //       height: 100,
            //       child: Column(
            //         children: [
            //           Text(c.product[index].productName),
            //           Text(c.product[index].productDetails),
            //           Text(c.product[index].productType),
            //           Text("จำนวน"),
            //           Text(c.product[index].amount.toString()),
            //           // ElevatedButton.icon(
            //           //   onPressed: () {
            //           //     c.product[index] = TextEditingController();
            //           //   },
            //           //   icon: Icon(Icons.edit),
            //           //   label: Text('Buttpn'),
            //           // ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // );
          },
          itemCount: c.product.length,
        ),
      ),
    );
  }
}
