// import 'package:flutter/material.dart';

// class CartItemWidget extends StatelessWidget {
//   final String imageUrl;
//   final String name;
//   final String brand;
//   final String price;
//   final int quantity;

//   CartItemWidget({
//     required this.imageUrl,
//     required this.name,
//     required this.brand,
//     required this.price,
//     // required this.quantity,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Image.network(imageUrl, width: 100, height: 150, fit: BoxFit.cover),
//             SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   Text(brand, style: TextStyle(color: Colors.grey)),
//                   Text(price, style: TextStyle(fontSize: 16)),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           IconButton(icon: Icon(Icons.remove), onPressed: () {}),
//                           Text('$quantity'),
//                           IconButton(icon: Icon(Icons.add), onPressed: () {}),
//                         ],
//                       ),
//                       IconButton(icon: Icon(Icons.delete_outline), onPressed: () {}),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }