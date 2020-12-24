// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class FacilitatorScreen extends StatefulWidget {
//
//   final String title = 'List Fasilitator';
//
//   @override
//   _FacilitatorScreenState createState() => _FacilitatorScreenState();
// }
//
// class _FacilitatorScreenState extends State<FacilitatorScreen> {
//
//   double _realWidth;
//   double _realHeight;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   void _calculateSize(BuildContext context) {
//     // Resolution 16:9
//
//     if (MediaQuery.of(context).size.width <
//         MediaQuery.of(context).size.height) {
//       _realWidth = MediaQuery.of(context).size.width;
//       _realHeight = MediaQuery.of(context).size.height;
//     } else {
//       _realHeight = MediaQuery.of(context).size.height;
//       _realWidth = _realHeight * (9 / 16);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     _calculateSize(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.black54,
//         ),
//         backgroundColor: Colors.white,
//         title: Text(
//           widget.title,
//           style: TextStyle(
//             color: Colors.black54,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: _realWidth,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: _realHeight * 0.05,
//               ),
//
//               // Wave 1
//               Container(
//                 width: _realWidth * 0.9,
//                 child: Text(
//                   'Gelombang 1',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//
//               SizedBox(
//                 height: _realWidth * 0.03,
//               ),
//
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10.0),
//                   ),
//                   color: Colors.green,
//                 ),
//                 width: _realWidth * 0.9,
//                 height: _realHeight * 0.094,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 13.0, vertical: 12.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           coloredText('Pengumpulan'),
//                           coloredText('Februari 2021', small: true),
//                         ],
//                       ),
//                     ),
//                     Icon(
//                       Icons.arrow_forward,
//                       size: 35.0,
//                       color: Colors.white,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 13.0, vertical: 12.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           coloredText('Penutupan'),
//                           coloredText('Maret 2021', small: true),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(
//                 height: _realHeight * 0.03,
//               ),
//
//               // Wave 2
//               Container(
//                 width: _realWidth * 0.9,
//                 child: Text(
//                   'Gelombang 2',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//
//               SizedBox(
//                 height: _realWidth * 0.03,
//               ),
//
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10.0),
//                   ),
//                   color: Colors.green,
//                 ),
//                 width: _realWidth * 0.9,
//                 height: _realHeight * 0.094,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 13.0, vertical: 12.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           coloredText('Pengumpulan'),
//                           coloredText('April 2021', small: true),
//                         ],
//                       ),
//                     ),
//                     Icon(
//                       Icons.arrow_forward,
//                       size: 35.0,
//                       color: Colors.white,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 13.0, vertical: 12.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           coloredText('Penutupan'),
//                           coloredText('Juni 2021', small: true),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(
//                 height: _realHeight * 0.03,
//               ),
//
//               // Wave 3
//               Container(
//                 width: _realWidth * 0.9,
//                 child: Text(
//                   'Gelombang 3',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//
//               SizedBox(
//                 height: _realWidth * 0.03,
//               ),
//
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10.0),
//                   ),
//                   color: Colors.green,
//                 ),
//                 width: _realWidth * 0.9,
//                 height: _realHeight * 0.094,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 13.0, vertical: 12.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           coloredText('Pengumpulan'),
//                           coloredText('Agustus 2021', small: true),
//                         ],
//                       ),
//                     ),
//                     Icon(
//                       Icons.arrow_forward,
//                       size: 35.0,
//                       color: Colors.white,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 13.0, vertical: 12.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           coloredText('Penutupan'),
//                           coloredText('September 2021', small: true),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(
//                 height: _realHeight * 0.03,
//               ),
//
//               // Wave 4
//               Container(
//                 width: _realWidth * 0.9,
//                 child: Text(
//                   'Gelombang 4',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//
//               SizedBox(
//                 height: _realWidth * 0.03,
//               ),
//
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10.0),
//                   ),
//                   color: Colors.green,
//                 ),
//                 width: _realWidth * 0.9,
//                 height: _realHeight * 0.094,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 13.0, vertical: 12.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           coloredText('Pengumpulan'),
//                           coloredText('Movember 2021', small: true),
//                         ],
//                       ),
//                     ),
//                     Icon(
//                       Icons.arrow_forward,
//                       size: 35.0,
//                       color: Colors.white,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 13.0, vertical: 12.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           coloredText('Penutupan'),
//                           coloredText('Desember 2021', small: true),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(
//                 height: _realHeight * 0.03,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
