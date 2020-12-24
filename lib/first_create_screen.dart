import 'package:energi_kolaborasi/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirstCreateScreen extends StatefulWidget {
  @override
  _FirstCreateScreenState createState() => _FirstCreateScreenState();
}

class _FirstCreateScreenState extends State<FirstCreateScreen> {

  double _realWidth = 0;
  double _realHeight = 0;

  void _calculateSize(BuildContext context) {
    // Resolution 16:9

    if (MediaQuery.of(context).size.width <
        MediaQuery.of(context).size.height) {
      _realWidth = MediaQuery.of(context).size.width;
      _realHeight = MediaQuery.of(context).size.height;
    } else {
      _realHeight = MediaQuery.of(context).size.height;
      _realWidth = _realHeight * (9 / 16);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    
    _calculateSize(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, RouteHandler.REGISTER_FORM),
        child: Container(
          width: _realWidth,
          height: _realHeight,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // Image
              // Text
              children: [
                Image(image: AssetImage('assets/images/f1.jpg'), width: _realWidth * 0.6, height: _realWidth * 0.6, fit: BoxFit.contain,),
                SizedBox(height: _realWidth * 0.2,),
                Container(
                  alignment: Alignment.center,

                  width: _realWidth * 0.9,
                  child: Text(
                    'Tinggal Sedikit Lagi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: _realWidth * 0.08,),
                Container(
                  alignment: Alignment.center,

                  width: _realWidth * 0.9,
                  child: Text(
                    'Lengkapi data diri anda untuk kemudahan akses fitur kami',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: _realWidth * 0.18,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
