import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energi_kolaborasi/models/collaboration_model.dart';
import 'package:energi_kolaborasi/utils/function.dart';
import 'package:energi_kolaborasi/widgets/detail_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CollaborationListScreen extends StatefulWidget {
  final int type;

  CollaborationListScreen({@required this.type});

  @override
  _CollaborationListScreenState createState() => _CollaborationListScreenState();
}

class _CollaborationListScreenState extends State<CollaborationListScreen> {
  String _titleIdentifier;
  List<CollaborationTeamModel> _teamCollaboration;
  List<CollaborationPartnerModel> _partnerCollaboration;
  int _tab = 0;

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
                title: Text('Proyek Kolaborasi ${_titleIdentifier ?? ''}'),
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

                      // Tab Bar
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            color: Color(0xffDCDCDC),
                          ),
                          width: _realWidth * 0.9,
                          height: _realHeight * 0.055,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_tab != 0) {
                                    setState(() {
                                      _tab = 0;
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: _realWidth * 0.45,
                                  height: _realHeight * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                    ),
                                    color: _tab == 0
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    'Partner',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                          color: _tab == 0
                                              ? Colors.white
                                              : Colors.black87,
                                          fontSize: _realWidth * 0.04,
                                        ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_tab != 1) {
                                    setState(() {
                                      _tab = 1;
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: _realWidth * 0.45,
                                  height: _realHeight * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                    color: _tab == 1
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    'Tim',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                          fontSize: _realWidth * 0.04,
                                          color: _tab == 1
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: _realWidth * 0.6,
                      ),

                      content(),

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

  Widget content() {

    switch (_tab) {

      case 0:
        if (_partnerCollaboration == null || _partnerCollaboration?.length == 0) {
          return Center(
            child: Column(
              children: [
                Container(
                  width: _realWidth * 0.7,
                  height: _realWidth * 0.7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/no-data.jpg'),
                          fit: BoxFit.fitWidth)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Tidak partner kolaborasi tersedia',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          );
        }
        break;
      case 1:
        if (_teamCollaboration == null || _teamCollaboration?.length == 0) {
          return Center(
            child: Column(
              children: [
                Container(
                  width: _realWidth * 0.7,
                  height: _realWidth * 0.7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/no-data.jpg'),
                          fit: BoxFit.fitWidth)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Tidak tim kolaborasi tersedia',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          );
        }
        break;
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: _tab == 0
          ? _partnerCollaboration.length
          : _teamCollaboration.length,
      itemBuilder: (BuildContext context, int index) {
        if (_tab == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: _realWidth * 0.02),
            child: DetailButton(
              size: _realWidth,
              title: _partnerCollaboration[index].title,
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(vertical: _realWidth * 0.02),
          child: DetailButton(
            size: _realWidth,
            title: _teamCollaboration[index].title,
          ),
        );
      },
    );

  }

  Future<void> _initializeData() async {
    String tempIdentifier;
    String documentIdentifier;
    switch (widget.type) {
      case 0:
        tempIdentifier = 'Riset';
        documentIdentifier = 'research';
        _teamCollaboration = List<CollaborationTeamModel>();
        _partnerCollaboration = List<CollaborationPartnerModel>();
        break;
      case 1:
        tempIdentifier = 'Startup';
        documentIdentifier = 'startup';
        _teamCollaboration = List<CollaborationTeamModel>();
        _partnerCollaboration = List<CollaborationPartnerModel>();
        break;
    }

    await FirebaseFirestore.instance
        .collection('collaboration')
        .where('category', isEqualTo: documentIdentifier)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.exists) {
          if (element.data()['search_for'] == 'partner') {
            _partnerCollaboration.add(CollaborationPartnerModel(
              uploader: element.data()['uploader'],
              projectId: element.data()['project_id'],
              category: element.data()['category'],
              skills: element.data()['skills'],
              description: element.data()['description'],
              title: element.data()['title'],
            ));
          }

          if (element.data()['search_for'] == 'team') {
            _teamCollaboration.add(CollaborationTeamModel(
              title: element.data()['title'],
              category: documentIdentifier,
              uploader: element.data()['uploader'],
              skills: element.data()['skills'],
              description: element.data()['description'],
            ));
          }
        }
      });
    });

    setState(() {
      _titleIdentifier = tempIdentifier;
      _initialized = true;
    });
  }
}
