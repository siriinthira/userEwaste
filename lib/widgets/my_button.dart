import 'dart:ffi' hide Size;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:user/views/details.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  // final String productName, productDescription;
  // final Int amount;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    const size = const Size(200, 50);
    return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: size,
          ),
          onPressed: onPress,
          child: Text(
            "บันทึกรายการ".toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
}







// import 'dart:ffi' hide Size;

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:user/details.dart';

// class MyButton extends StatelessWidget {
//   const MyButton({
//     Key? key,
//     required this.productName,
//     required this.productDescription,
//     required this.amount,
//   }) : super(key: key);

//   final String productName, productDescription;
//   final Int amount;

//   @override
//   Widget build(BuildContext context) {
//     const size = const Size(200, 50);
//     return Padding(
//       padding: const EdgeInsets.only(top: 30.0),
//       child: OutlinedButton(
//         style: OutlinedButton.styleFrom(
//           minimumSize: size,
//         ),
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) {
//               return Details(
//                   productName: this.productName,
//                   productDes: this.productDescription,
//                   amount: this.amount.toString());
//             },
//           ));
//         },
//         child: null,
//       ),
//     );
//   }
// }
