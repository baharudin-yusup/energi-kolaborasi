import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energi_kolaborasi/models/place_model.dart';
import 'package:energi_kolaborasi/models/project_model.dart';
import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:energi_kolaborasi/utils/function.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:energi_kolaborasi/widgets/dropdown_picker.dart';
import 'package:energi_kolaborasi/widgets/feature_button.dart';
import 'package:energi_kolaborasi/widgets/header_image.dart';
import 'package:energi_kolaborasi/widgets/string_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FindTeamScreen extends StatefulWidget {

  final String title = 'Cari Tim';

  final int type;


  FindTeamScreen(this.type);

  @override
  _FindTeamScreenState createState() => _FindTeamScreenState();
}

class _FindTeamScreenState extends State<FindTeamScreen> {
  bool _initialized = false;
  String _title;


  double _realWidth;
  double _realHeight;
  double _mediaWidth;
  double _mediaHeight;
  bool _perfectRatio = true;

  String _category;

  OptionModel _placeModel;
  List<DropdownMenuItem> _projectList;

  String _field;
  String _fieldDatabase;

  @override
  void initState() {
    _initializeVariable();

    // _initializeProject();

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

  bool _firstTime = true;

  @override
  Widget build(BuildContext context) {
    _checkSize();

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
                        height: _realWidth * 0.03,
                      ),
                      HeaderImage(
                        title: 'Cari Tim',
                        size: _realWidth,
                        image: AssetImage('assets/images/collaboration.jpg'),
                        subtitle: 'Mencari tim yang tepat sesuai keinginan Anda',
                      ),
                      SizedBox(
                        height: _realWidth * 0.1,
                      ),

                      Text(
                        'Judul Pencarian',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: _realWidth * 0.03,
                      ),
                      StringInput(size: _realWidth, hint: 'Judul Pencarian', onChanged: (value) {
                        setState(() {
                          _title = value;
                        });
                      }),

                      Text(
                        'Bidang $_field yang dicari',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: _realWidth * 0.03,
                      ),
                      DropdownPicker.single(
                        size: _realWidth,
                        hint: 'Pilih bidang yang dicari',
                        items: _placeModel.categoryList,
                        onChanged: (value) {
                          setState(() {
                            _category = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: _realWidth * 0.1,
                      ),

                      Text(
                        'Skill atau profesi yang Anda tawarkan',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: _realWidth * 0.03,
                      ),
                      DropdownPicker.single(
                        size: _realWidth,
                        hint: 'Skill atau Pekerjaan 1',
                        items: _placeModel.jobList,
                        onChanged: (value) {
                          while (_jobOffered.length < 1) {
                            _jobOffered.add(null);
                          }
                          setState(() {
                            _jobOffered[0] = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: _realWidth * 0.03,
                      ),
                      DropdownPicker.single(
                        size: _realWidth,
                        hint: 'Skill atau Pekerjaan 2',
                        items: _placeModel.jobList,
                        onChanged: (value) {
                          while (_jobOffered.length < 2) {
                            _jobOffered.add(null);
                          }
                          setState(() {
                            _jobOffered[1] = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: _realWidth * 0.03,
                      ),
                      DropdownPicker.single(
                        size: _realWidth,
                        hint: 'Skill atau Pekerjaan 3',
                        items: _placeModel.jobList,
                        onChanged: (value) {
                          while (_jobOffered.length < 3) {
                            _jobOffered.add(null);
                          }
                          setState(() {
                            _jobOffered[2] = value;
                          });
                        },
                      ),

                      SizedBox(
                        height: _realWidth * 0.1,
                      ),
                      Text(
                        'Deskripsi keinginan tim yang ingin Anda ikuti',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: _realWidth * 0.03,
                      ),
                      StringInput(
                        keyboardType: TextInputType.multiline,
                        size: _realWidth,
                        hint: 'Deskripsi keinginan tim yang ingin Anda ikuti',
                        onChanged: (value) {
                          setState(() {
                            _description = value;
                          });
                          print(_description);
                        },
                        type: StringInputType.long,
                      ),
                      SizedBox(
                        height: _realWidth * 0.2,
                      ),

                      FeatureButton(
                        title: 'Ajukan',
                        size: _realWidth,
                        onTap: sendData,
                      ),
                      SizedBox(
                        height: _realWidth * 0.1,
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

  String _description;
  List<String> _jobOffered;

  // Future<void> _initializeProject() async {
  //   await FirebaseFirestore.instance
  //       .collection(widget.type == 0 ? 'research' : 'startup')
  //       .where(UserModel.instance.uid)
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       if (element.exists) {
  //         _projectList.add(DropdownMenuItem(
  //           child: Text(element.data()[ProjectModel.TITLE]),
  //           value: element.id,
  //         ));
  //       }
  //     });
  //   });
  //
  //   setState(() {
  //     _initialized = true;
  //   });
  // }

  void _initializeVariable() {
    switch (widget.type) {
    // RESEARCH
      case 0:
        _field = 'Riset';
        _fieldDatabase = 'research';
        break;
      case 1:
        _field = 'Startup';
        _fieldDatabase = 'startup';
        break;
    }

    _jobOffered = List<String>();
    _projectList = List<DropdownMenuItem>();
    _placeModel = OptionModel.instance;
  }

  Future<void> sendData() async {
    if (_category == null) {
      EasyLoading.showError(
          'Pilih $_field yang Anda cari terlebih dahulu',
          duration: Duration(seconds: 3),
          dismissOnTap: true);
      return;
    }

    if (_jobOffered.length == 0) {
      EasyLoading.showError('Pilih minimal 1 keahlian yang tawarkan',
          duration: Duration(seconds: 3), dismissOnTap: true);
      return;
    }

    if (_title == null) {
      EasyLoading.showError(
          'Masukkan judul pencarian',
          duration: Duration(seconds: 3),
          dismissOnTap: true);
      return;
    }

    EasyLoading.showProgress(0.1, status: 'Mengajukan data');

    var jobChoice = [];

    for (int i = 0; i < _jobOffered.length; i++) {
      if (_jobOffered[i] != null) {
        jobChoice.add(_jobOffered[i]);
      }
    }

    EasyLoading.showProgress(0.3, status: 'Mengajukan data');


    await FirebaseFirestore.instance.collection('collaborators').add({
      'uploader': UserModel.instance.uid,
      'category': _fieldDatabase,
      'skills': jobChoice,
      'description': _description,
      'title': _title,
    });

    EasyLoading.showProgress(1.0, status: 'Mengajukan data');

    EasyLoading.dismiss();

    EasyLoading.showInfo('Data sudah diterima oleh sistem', duration: Duration(seconds: 3));

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RouteHandler.HOME);
    });
  }
}
