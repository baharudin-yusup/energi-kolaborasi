// import 'package:flutter/material.dart';
//
// class ProjectRegisterScreen extends StatefulWidget {
//   final String title = 'Mulai Projek Riset';
//   @override
//   _ProjectRegisterScreenState createState() => _ProjectRegisterScreenState();
// }
//
// class _ProjectRegisterScreenState extends State<ProjectRegisterScreen> {
//   double _realWidth = 0;
//   double _realHeight = 0;
//
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
//     _calculateSize(context);
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
//               Container(
//                 width: _realWidth * 0.9,
//                 child: Text(
//                   'Informasi Pribadi',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 25.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: _realWidth * 0.03,),
//
//               formWidget('Nama Lengkap'),
//
//               SizedBox(height: _realWidth * 0.03,),
//
//               formWidget('Tempat dan Tanggal Lahir'),
//
//               SizedBox(height: _realWidth * 0.03,),
//
//               formWidget('Asal Institusi'),
//
//               SizedBox(height: _realWidth * 0.03,),
//
//               formWidget('Bidang Riset'),
//
//               SizedBox(height: _realWidth * 0.03,),
//
//               formWidget('E-Mail'),
//
//               SizedBox(height: _realWidth * 0.03,),
//
//               formWidget('No. Handphone'),
//
//               SizedBox(height: _realWidth * 0.03,),
//
//               formWidget('Alamat'),
//
//               SizedBox(height: _realWidth * 0.03,),
//
//               formWidget('Provinsi'),
//
//               SizedBox(height: _realWidth * 0.03,),
//
//               formWidget('Kota'),
//
//               SizedBox(height: _realWidth * 0.03,),
//
//               formWidget('Kecamatan'),
//
//               SizedBox(height: _realWidth * 0.07,),
//
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(20.0),
//                   ),
//                   color: Colors.green,
//                 ),
//                 width: _realWidth * 0.9,
//                 height: _realHeight * 0.07,
//               ),
//
//               SizedBox(height: _realWidth * 0.1,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget formWidget(String title) {
//     return Container(
//       width: _realWidth * 0.9,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 15.0,
//               fontWeight: FontWeight.bold,
//             ),
//
//           ),
//
//           SizedBox(height: _realWidth * 0.02,),
//           // List
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10.0),
//               ),
//               color: Colors.black54,
//             ),
//             width: _realWidth * 0.9,
//             height: _realHeight * 0.06,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
