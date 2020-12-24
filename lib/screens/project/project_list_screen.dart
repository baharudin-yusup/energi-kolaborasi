import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energi_kolaborasi/models/project_model.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:energi_kolaborasi/widgets/feature_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_easyloading/flutter_easyloading.dart';

enum ProjectListType {
  research,
  consultation,
  funding,
  startup,
}

class ProjectListScreen extends StatefulWidget {
  final ProjectListType type;

  ProjectListScreen({@required this.type});

  @override
  _ProjectListScreenState createState() =>
      _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {

  bool _initialized = false;
  String _title;

  _ProjectListScreenState();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_mediaHeight != MediaQuery.of(context).size.height ||
        _mediaWidth != MediaQuery.of(context).size.width) {
      _calculateSize(context);
    }
  }

  double _realWidth;
  double _realHeight;
  double _mediaWidth;
  double _mediaHeight;
  double _maxWidth;

  @override
  void initState() {
    _initializeData();

    super.initState();
  }

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
      if (_mediaHeight != MediaQuery.of(context).size.height ||
          _mediaWidth != MediaQuery.of(context).size.width) {
        _mediaHeight = MediaQuery.of(context).size.height;
        _mediaWidth = MediaQuery.of(context).size.width;

        setState(() {
          _realWidth = _mediaWidth;
          _realHeight = _mediaHeight;
          _maxWidth = _realWidth;
        });
      }
    }
  }

  int tab = 0;

  void _goTo(
      {bool verified = false, bool process = false, bool rejected = false}) {
    setState(() {
      if (verified) {
        print('click 1');

        tab = 1;
      }
      if (process) {
        print('click 0');

        tab = 0;
      }
      if (rejected) {
        print('click -1');

        tab = -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoading) {
      EasyLoading.show(status: 'Mohon tunguu', dismissOnTap: true);
    }

    if (_initialized) {
      EasyLoading.dismiss();
    }

    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        color: _sameRatio == true ? Colors.white : Colors.black12,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: _realHeight,
              maxWidth: _maxWidth,
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  _title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: _realWidth * 0.1,
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
                              onTap: () => _goTo(verified: true),
                              child: Container(
                                alignment: Alignment.center,
                                width: _realWidth * 0.3,
                                height: _realHeight * 0.055,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                  color: tab == 1
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  'Terverifikasi',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: tab == 1
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: _realWidth * 0.04,
                                      ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _goTo(process: true);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: _realWidth * 0.3,
                                height: _realHeight * 0.055,
                                decoration: BoxDecoration(
                                  color: tab == 0
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  'Dalam Proses',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: tab == 0
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: _realWidth * 0.04,
                                      ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _goTo(rejected: true);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: _realWidth * 0.3,
                                height: _realHeight * 0.055,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                  color: tab == -1
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  'Ditolak',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        fontSize: _realWidth * 0.04,
                                        color: tab == -1
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
                      height: _realWidth * 0.2,
                    ),

                    _initialized
                        ? listContent()
                        : SizedBox(
                            height: _realWidth * 0.2,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<ProjectModel> _rejectedProjects = List<ProjectModel>();
  List<ProjectModel> _processedProjects = List<ProjectModel>();
  List<ProjectModel> _verifiedProjects = List<ProjectModel>();

  bool _showLoading = true;

  Future<void> _initializeData() async {

    switch (widget.type) {
      // Research Model
      case ProjectListType.research:

        _title = 'Daftar Semua Pengajuan Riset';

        await FirebaseFirestore.instance
            .collection('research')
            .get()
            .then((snapshot) {
          snapshot.docs.forEach((element) {
            switch (element.data()['level']) {
              case 0:
                _processedProjects.add(ProjectModel.name(
                    element.id,
                    element.data()[ProjectModel.RESEARCH_CATEGORY],
                    element.data()[ProjectModel.EMAIL],
                    element.data()[ProjectModel.INSTITUTION],
                    element.data()[ProjectModel.LEVEL],
                    element.data()[ProjectModel.PHONE_NUMBER],
                    element.data()[ProjectModel.TITLE],
                    element.data()[ProjectModel.UPLOADER],
                    abstractFile: Map<String, String>.from(element.data()[ProjectModel.ABSTRACT_URL]),
                    designFile: Map<String, String>.from(element.data()[ProjectModel.DESIGN_URL]),
                    financeFile: Map<String, String>.from(element.data()[ProjectModel.FINANCE_URL]),),);
                break;
              case 1:
                _verifiedProjects.add(ProjectModel.name(
                    element.id,
                    element.data()[ProjectModel.RESEARCH_CATEGORY],
                    element.data()[ProjectModel.EMAIL],
                    element.data()[ProjectModel.INSTITUTION],
                    element.data()[ProjectModel.LEVEL],
                    element.data()[ProjectModel.PHONE_NUMBER],
                    element.data()[ProjectModel.TITLE],
                    element.data()[ProjectModel.UPLOADER],
                    abstractFile: Map<String, String>.from(element.data()[ProjectModel.ABSTRACT_URL]),
                    designFile: Map<String, String>.from(element.data()[ProjectModel.DESIGN_URL]),
                    financeFile: Map<String, String>.from(element.data()[ProjectModel.FINANCE_URL])));
                break;
              case -1:
                _rejectedProjects.add(ProjectModel.name(
                    element.id,
                    element.data()[ProjectModel.RESEARCH_CATEGORY],
                    element.data()[ProjectModel.EMAIL],
                    element.data()[ProjectModel.INSTITUTION],
                    element.data()[ProjectModel.LEVEL],
                    element.data()[ProjectModel.PHONE_NUMBER],
                    element.data()[ProjectModel.TITLE],
                    element.data()[ProjectModel.UPLOADER],
                    abstractFile: Map<String, String>.from(element.data()[ProjectModel.ABSTRACT_URL]),
                    designFile: Map<String, String>.from(element.data()[ProjectModel.DESIGN_URL]),
                    financeFile: Map<String, String>.from(element.data()[ProjectModel.FINANCE_URL])));
                break;
            }
          });
        });
        break;

      // Startup Model
      case ProjectListType.startup:
        _title = 'Daftar Semua Pengajuan Startup';
        await FirebaseFirestore.instance
            .collection('startup')
            .get()
            .then((snapshot) {
          snapshot.docs.forEach((element) {
            switch (element.data()['level']) {
              case 0:
                _processedProjects.add(ProjectModel.name(
                    element.id,
                    element.data()[ProjectModel.RESEARCH_CATEGORY],
                    element.data()[ProjectModel.EMAIL],
                    element.data()[ProjectModel.INSTITUTION],
                    element.data()[ProjectModel.LEVEL],
                    element.data()[ProjectModel.PHONE_NUMBER],
                    element.data()[ProjectModel.TITLE],
                    element.data()[ProjectModel.UPLOADER],
                    proposalFile: Map<String, String>.from(element.data()[ProjectModel.PROPOSAL_URL]),
            pitchDeckFile:
            Map<String, String>.from(element.data()[ProjectModel.PITCH_DECK_URL])));
                break;
              case 1:
                _verifiedProjects.add(ProjectModel.name(
                    element.id,
                    element.data()[ProjectModel.RESEARCH_CATEGORY],
                    element.data()[ProjectModel.EMAIL],
                    element.data()[ProjectModel.INSTITUTION],
                    element.data()[ProjectModel.LEVEL],
                    element.data()[ProjectModel.PHONE_NUMBER],
                    element.data()[ProjectModel.TITLE],
                    element.data()[ProjectModel.UPLOADER],
                    proposalFile: Map<String, String>.from(element.data()[ProjectModel.PROPOSAL_URL]),
                    pitchDeckFile:
                    Map<String, String>.from(element.data()[ProjectModel.PITCH_DECK_URL])));
                break;
              case -1:
                _rejectedProjects.add(ProjectModel.name(
                    element.id,
                    element.data()[ProjectModel.RESEARCH_CATEGORY],
                    element.data()[ProjectModel.EMAIL],
                    element.data()[ProjectModel.INSTITUTION],
                    element.data()[ProjectModel.LEVEL],
                    element.data()[ProjectModel.PHONE_NUMBER],
                    element.data()[ProjectModel.TITLE],
                    element.data()[ProjectModel.UPLOADER],
                    proposalFile: Map<String, String>.from(element.data()[ProjectModel.PROPOSAL_URL]),
                    pitchDeckFile:
                    Map<String, String>.from(element.data()[ProjectModel.PITCH_DECK_URL])));
                break;
            }
          });
        });
        break;
        // Default
      default:
        _title = 'Daftar Semua Pengajuan Riset';

        await FirebaseFirestore.instance
            .collection('research')
            .get()
            .then((snapshot) {
          snapshot.docs.forEach((element) {
            switch (element.data()['level']) {
              case 0:
                _processedProjects.add(ProjectModel.name(
                  element.id,
                  element.data()[ProjectModel.RESEARCH_CATEGORY],
                  element.data()[ProjectModel.EMAIL],
                  element.data()[ProjectModel.INSTITUTION],
                  element.data()[ProjectModel.LEVEL],
                  element.data()[ProjectModel.PHONE_NUMBER],
                  element.data()[ProjectModel.TITLE],
                  element.data()[ProjectModel.UPLOADER],
                  abstractFile: Map<String, String>.from(element.data()[ProjectModel.ABSTRACT_URL]),
                  designFile: Map<String, String>.from(element.data()[ProjectModel.DESIGN_URL]),
                  financeFile: Map<String, String>.from(element.data()[ProjectModel.FINANCE_URL]),),);
                break;
              case 1:
                _verifiedProjects.add(ProjectModel.name(
                    element.id,
                    element.data()[ProjectModel.RESEARCH_CATEGORY],
                    element.data()[ProjectModel.EMAIL],
                    element.data()[ProjectModel.INSTITUTION],
                    element.data()[ProjectModel.LEVEL],
                    element.data()[ProjectModel.PHONE_NUMBER],
                    element.data()[ProjectModel.TITLE],
                    element.data()[ProjectModel.UPLOADER],
                    abstractFile: Map<String, String>.from(element.data()[ProjectModel.ABSTRACT_URL]),
                    designFile: Map<String, String>.from(element.data()[ProjectModel.DESIGN_URL]),
                    financeFile: Map<String, String>.from(element.data()[ProjectModel.FINANCE_URL])));
                break;
              case -1:
                _rejectedProjects.add(ProjectModel.name(
                    element.id,
                    element.data()[ProjectModel.RESEARCH_CATEGORY],
                    element.data()[ProjectModel.EMAIL],
                    element.data()[ProjectModel.INSTITUTION],
                    element.data()[ProjectModel.LEVEL],
                    element.data()[ProjectModel.PHONE_NUMBER],
                    element.data()[ProjectModel.TITLE],
                    element.data()[ProjectModel.UPLOADER],
                    abstractFile: Map<String, String>.from(element.data()[ProjectModel.ABSTRACT_URL]),
                    designFile: Map<String, String>.from(element.data()[ProjectModel.DESIGN_URL]),
                    financeFile: Map<String, String>.from(element.data()[ProjectModel.FINANCE_URL])));
                break;
            }
          });
        });
        break;
    }

    setState(() {
      _initialized = true;
      _showLoading = false;
    });
  }

  Widget listContent() {
    switch (tab) {
      case -1:
        if (_rejectedProjects == null || _rejectedProjects?.length == 0) {
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
                    'Tidak ada data pengajuan yang ditolak',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          );
        }
        // else {
        //   if (_rejectedProjects.length == 0) {
        //     return Center(
        //       child: Text(
        //         'Tidak ada data riset yang ditolak :)',
        //         style: Theme.of(context).textTheme.headline4,
        //       ),
        //     );
        //   }
        // }
        break;
      case 0:
        if (_processedProjects == null || _processedProjects?.length == 0) {
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
                    'Tidak ada data pengajuan yang diproses',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          );
        }
        // else {
        //   if (_processedProjects.length == 0) {
        //     return Center(
        //       child: Text(
        //         'Tidak ada data riset yang diproses :(',
        //         style: Theme.of(context).textTheme.headline4,
        //       ),
        //     );
        //   }
        // }
        break;
      case 1:
        if (_verifiedProjects == null || _verifiedProjects?.length == 0) {
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
                    'Tidak ada data pengajuan yang diverifikasi',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          );
        }
        // else {
        //   if (_verifiedProjects.length == 0) {
        //     return Center(
        //       child: Text(
        //         'Tidak ada data riset yang terverifikasi :(',
        //         style: Theme.of(context).textTheme.headline4,
        //       ),
        //     );
        //   }
        // }
        break;
    }

    int counts = tab == -1
        ? _rejectedProjects.length
        : tab == 0
            ? _processedProjects.length
            : _verifiedProjects.length;

    List<ProjectModel> research = tab == -1
        ? _rejectedProjects
        : tab == 0
            ? _processedProjects
            : _verifiedProjects;

    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: counts,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(
              left: _realWidth * 0.05,
              right: _realWidth * 0.05,
              bottom: _realHeight * 0.025),
          child: featureBanner(
            context: context,
            background: AssetImage('assets/images/research-default.jpg'),
            title: research[index].title,
            icon: Icons.circle,
            baseWidth: _realWidth,
            baseHeight: _realHeight,
            route: RouteHandler.RESEARCH_DETAIL_SCREEN,
            arguments: research[index],
          ),
        );
      },
    );
  }
}
