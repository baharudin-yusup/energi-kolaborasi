import 'package:energi_kolaborasi/utils/function.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:energi_kolaborasi/widgets/header_image.dart';
import 'package:flutter/material.dart';

class UncompletedDataScreen extends StatefulWidget {
  @override
  _UncompletedDataScreenState createState() => _UncompletedDataScreenState();
}

class _UncompletedDataScreenState extends State<UncompletedDataScreen> {
  double _realWidth;
  double _realHeight;
  double _mediaWidth;
  double _mediaHeight;
  bool _perfectRatio = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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

    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        color: _perfectRatio == true ? Colors.white : Colors.black12,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: _realHeight,
              maxWidth: _realWidth,
            ),
            child: InkWell(
              child: Column(
                children: [
                  SizedBox(height: _realWidth * 0.5,),
                  HeaderImage(
                    title: 'Informasi Akun Anda Belum Lengkap',
                    size: _realWidth,
                    image: AssetImage('assets/images/collaboration.jpg'),
                    subtitle: 'Tolong lengkapi data diri Anda terlebih dahulu sebelum menggunakan fitur ini, klik disini untuk melengkapi data diri Anda',
                  ),
                ],
              ),
              onTap: () => Navigator.pushReplacementNamed(context, RouteHandler.PROFILE_APPLICANT),
            ),
          ),
        ),
      ),
    );
  }
}
