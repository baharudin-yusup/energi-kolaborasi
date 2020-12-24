import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class InboxScreen extends StatefulWidget {

  final String title = 'Inbox';

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {


  @override
  void initState() {



    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_mediaHeight != MediaQuery.of(context).size.height ||
        _mediaWidth != MediaQuery.of(context).size.width) {
      _calculateSize(context);
    }

  }

  double _realWidth =  0;
  double _realHeight = 0;
  double _mediaWidth = 0;
  double _mediaHeight = 0;
  double _maxWidth = 0;
  bool _sameRatio = true;

  void _calculateSize(BuildContext context) {
    if (kIsWeb) {
      print(_sameRatio ? 'YA' : 'NO');

      // TODO: Resolution 16:9

      // Portrait\

      if (_mediaHeight != MediaQuery.of(context).size.height ||
          _mediaWidth != MediaQuery.of(context).size.width) {
        _mediaHeight = MediaQuery.of(context).size.height;
        _mediaWidth = MediaQuery.of(context).size.width;

        double tempHeight = MediaQuery.of(context).size.height;
        double tempWidth = tempHeight * (9 / 16);
        bool ratioChange;

        print((MediaQuery.of(context).size.width - tempWidth).abs());
        print('W=> $tempWidth \t ${tempWidth * 0.1}');
        if ((MediaQuery.of(context).size.width - tempWidth).abs() <=
            tempWidth * 0.1) {
          ratioChange = true;
        } else {
          ratioChange = false;
        }

        setState(() {
          _realHeight = tempHeight;
          _realWidth = tempWidth;
          _sameRatio = ratioChange;
          _maxWidth = _realWidth;
        });
      }
    } else {
      print('[${widget.title}]\t W1=> $_realWidth \tH1=>  $_realHeight');

      if (_mediaHeight != MediaQuery.of(context).size.height ||
          _mediaWidth != MediaQuery.of(context).size.width) {
        _mediaHeight = MediaQuery.of(context).size.height;
        _mediaWidth = MediaQuery.of(context).size.width;

        setState(() {
          _realWidth = _mediaWidth;
          _realHeight = _mediaHeight;
          _maxWidth = _realWidth;
          print('[${widget.title}]S\t W2=> $_realWidth \tH2=>  $_realHeight');
        });
      }
      print('[${widget.title}]\t W2=> $_realWidth \tH2=>  $_realHeight');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: _realWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: _realHeight * 0.08,
                ),

                Container(
                  width: _realWidth * 0.9,
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline1,

                  ),
                ),

                Container(
                  width: _realWidth * 0.9,
                  child: Text(
                    'Kamu tidak mempunyai pesan tidak terbaca',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
