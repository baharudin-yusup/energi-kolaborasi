import 'package:energi_kolaborasi/models/facilitator_model.dart';
import 'package:energi_kolaborasi/utils/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



class FacilitatorScreen extends StatefulWidget {

  final FacilitatorType type;
  FacilitatorScreen({this.type});

  @override
  _FacilitatorScreenState createState() => _FacilitatorScreenState();
}

class _FacilitatorScreenState extends State<FacilitatorScreen> {
  bool _initialized = false;
  bool _firstTime = true;

  String _title;

  double _realWidth;
  double _realHeight;
  double _mediaWidth;
  double _mediaHeight;
  bool _perfectRatio = true;


  @override
  void initState() {

    _initializeData();

    super.initState();
  }

  void _checkSize() {
    if ((_mediaHeight ?? 0) != MediaQuery.of(context).size.height ||
        (_mediaWidth ?? 0) != MediaQuery.of(context).size.width) {
      Map<String, dynamic> media = calculateSize(
        context,
        mediaHeight: _mediaHeight,
        mediaWidth: _mediaWidth,
        realHeight: _realHeight,
        realWidth: _realWidth,
        perfectRatio: _perfectRatio,
      );

      setState(() {
        _mediaHeight = media['media_height'];
        _mediaHeight = media['media_width'];
        _realHeight = media['real_height'];
        _realWidth = media['real_width'];
        _perfectRatio = media['perfect_ratio'];
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    _checkSize();

    if (!_initialized) {

      if (!EasyLoading.isShow) {
        EasyLoading.show(status: 'Mohon Tunggu', dismissOnTap: false);
      }

      setState(() {
        _firstTime = false;
      });
    }

    if (EasyLoading.isShow && !_firstTime) EasyLoading.dismiss();

    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        color: _perfectRatio == true ? Colors.white : Colors.black12,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: _realHeight,
              maxWidth: _realWidth,
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(_title ?? ''),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _realWidth * 0.05),
                  child: Column(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _initializeData() {

    String tempTitle;
    switch (widget.type) {
      case FacilitatorType.facilitator :
        tempTitle = 'List Fasilitator';
        break;
      case FacilitatorType.consultant :
        tempTitle = 'List Konsultan';
        break;
      case FacilitatorType.investor :
        tempTitle = 'List Pendana';
        break;
    }

    setState(() {
      _title = tempTitle;
      _initialized = true;
    });

  }
}
