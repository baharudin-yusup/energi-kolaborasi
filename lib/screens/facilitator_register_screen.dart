import 'package:energi_kolaborasi/models/facilitator_model.dart';
import 'package:energi_kolaborasi/utils/function.dart';
import 'package:energi_kolaborasi/widgets/header_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FacilitatorRegisterScreen extends StatefulWidget {

  final FacilitatorType type;

  FacilitatorRegisterScreen({this.type});


  @override
  _FacilitatorRegisterScreenState createState() => _FacilitatorRegisterScreenState();
}

class _FacilitatorRegisterScreenState extends State<FacilitatorRegisterScreen> {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: _realWidth * 0.12,),

                      HeaderImage(title: _title, size: _realWidth, image: AssetImage('assets/images/collaboration.jpg')),
                      SizedBox(height: _realWidth * 0.06,),

                      Text('Informasi Pribadi', style: Theme.of(context).textTheme.headline5,),
                      SizedBox(height: _realWidth * 0.03,),

                      SizedBox(height: _realWidth * 0.12,),
                    ],
                  ),
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
        tempTitle = 'Menjadi Fasilitator';
        break;
      case FacilitatorType.consultant :
        tempTitle = 'Menjadi Konsultan';
        break;
      case FacilitatorType.investor :
        tempTitle = 'Menjadi Pendana';
        break;
    }

    setState(() {
      _title = tempTitle;
      _initialized = true;
    });

  }
}
