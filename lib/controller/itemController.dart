import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/views/additem.dart';
import 'package:user/models/item_model.dart';
import 'package:user/views/form.dart';

class ItemController extends GetxController {
  //List
  final RxList<ItemDetails> _itemDetails = <ItemDetails>[].obs;

  RxList<ItemDetails> get product => _itemDetails;

  addItem(ItemDetails itemDetails) {
    _itemDetails.add(itemDetails);
  }

  removeItem(int id) {
    product.removeWhere((item) => item.item_id == id);
  }

  updateItem(int id) {
    ItemDetails itemDetails = ItemDetails(
        item_id: 123,
        amount: 1,
        item_name: 'phone',
        item_desc: 'usable',
        ewtype_id: '4');
    //get product details as first value
    // var value_result = product.firstWhere((item) => item.id == id);
    //get index
    var index_result = product.indexWhere((item) => item.item_id == id);
    product[index_result] = itemDetails;
  }
}
