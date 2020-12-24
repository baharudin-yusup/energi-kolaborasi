import 'package:energi_kolaborasi/models/timeline_model.dart';
import 'package:energi_kolaborasi/utils/function.dart';
import 'package:energi_kolaborasi/widgets/header_image.dart';
import 'package:energi_kolaborasi/widgets/timeline_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TimelineScreen extends StatefulWidget {
  final String title = 'Lini Waktu';

  final type;


  TimelineScreen(this.type);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {

  String _titleIdentifier;
  List<TimelineModel> _timelineList;


  bool _initialized = false;
  bool _firstTime = true;

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

  @override
  Widget build(BuildContext context) {

    _checkResolution();

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
                title: Text(widget.title),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _realWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: _realWidth * 0.06,
                      ),

                      HeaderImage(
                        title: 'Kalender ${_titleIdentifier ?? ''} Energi Kolaborasi',
                        size: _realWidth,
                        image: AssetImage('assets/images/collaboration.jpg'),
                        subtitle: 'Jangan lupa catat tanggalnya!',
                      ),
                      SizedBox(
                        height: _realWidth * 0.12,
                      ),

                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                        itemCount: _timelineList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {

                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: _realWidth * 0.02),
                            child: TimelineCard(
                                size: _realWidth,
                                headline: _timelineList[index].headline,
                                startDate: _timelineList[index].startDate,
                                endDate: _timelineList[index].endDate),
                          );
                        },

                      ),

                      SizedBox(
                        height: _realWidth * 0.2,
                      ),
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

  void _checkResolution() {
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

  void _initializeData() {

    _timelineList = List<TimelineModel>();

    for (int i = 1; i <= 4; i++) {

      _timelineList.add(TimelineModel(
        headline: 'Gelombang $i',
        startTitle: 'Pengumpulan',
        endTitle: 'Penutupan',
        startDate: DateTime(2020, i * 2, 21),
        endDate: DateTime(2020, (i * 2) + 2, 21),
      ));
    }

    String tempIdentifier;
    switch(widget.type) {
      case 0:
        tempIdentifier = 'Riset';
        break;
      case 1:
        tempIdentifier = 'Konsultasi';
        break;
      case 2:
        tempIdentifier = 'Pendanaan';
        break;
      case 3:
        tempIdentifier = 'Startup';
        break;
    }

    setState(() {
      _titleIdentifier = tempIdentifier;
      _initialized = true;
    });

  }

}
