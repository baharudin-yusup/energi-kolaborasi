import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:energi_kolaborasi/utils/function.dart' show calculateSize;
import 'package:energi_kolaborasi/widgets/choice_tile.dart';
import 'package:energi_kolaborasi/widgets/feature_button.dart';
import 'package:energi_kolaborasi/widgets/header_image.dart';
import 'package:flutter/material.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:energi_kolaborasi/widgets/inner_header.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CollaborationOptionScreen extends StatefulWidget {
  final String title = 'Proyek Kolaborasi';

  @override
  _CollaborationOptionScreenState createState() =>
      _CollaborationOptionScreenState();
}

class _CollaborationOptionScreenState extends State<CollaborationOptionScreen> {
  int _category;
  int _type;

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
              body: Container(
                alignment: Alignment.topCenter,
                width: _realWidth,
                height: _realHeight,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _realWidth * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: _realWidth * 0.01,
                        ),

                        HeaderImage(
                          title: 'Cari rekan atau tim kolaborasimu',
                          size: _realWidth,
                          image: AssetImage('assets/images/collaboration.jpg'),
                          subtitle:
                              'Pilih apa yang kamu perlukan sekarang juga!',
                        ),
                        SizedBox(
                          height: _realWidth * 0.03,
                        ),

                        // Select Category Title
                        Container(
                          width: _realWidth * 0.9,
                          child: Text(
                            'Kategori',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        SizedBox(
                          height: _realWidth * 0.02,
                        ),

                        // Research
                        ChoiceTile(
                          size: _realWidth,
                          activeTitle: 'Riset',
                          activeColor: Theme.of(context).primaryColor,
                          passiveColor: Theme.of(context).accentColor,
                          activeLeading: FontAwesomeIcons.microscope,
                          isActive: _category == 0 ? true : false,
                          onTap: () {
                            if (_category != 0) {
                              setState(() {
                                _category = 0;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: _realWidth * 0.01,
                        ),

                        // Startup
                        ChoiceTile(
                          size: _realWidth,
                          activeTitle: 'Startup',
                          activeColor: Theme.of(context).primaryColor,
                          passiveColor: Theme.of(context).accentColor,
                          activeLeading: FontAwesomeIcons.businessTime,
                          isActive: _category == 1 ? true : false,
                          onTap: () {
                            if (_category != 1) {
                              setState(() {
                                _category = 1;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: _realWidth * 0.07,
                        ),

                        // Partner Title
                        Container(
                          width: _realWidth * 0.9,
                          child: Text(
                            'Cari Kolaborasi',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        SizedBox(
                          height: _realWidth * 0.02,
                        ),

                        // Partner
                        ChoiceTile(
                          size: _realWidth,
                          activeTitle: 'Partner',
                          activeColor: Theme.of(context).primaryColor,
                          passiveColor: Theme.of(context).accentColor,
                          activeLeading: FontAwesomeIcons.personBooth,
                          isActive: _type == 0 ? true : false,
                          onTap: () {
                            if (_type != 0) {
                              setState(() {
                                _type = 0;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: _realWidth * 0.01,
                        ),

                        // Team
                        ChoiceTile(
                          size: _realWidth,
                          activeTitle: 'Tim',
                          activeColor: Theme.of(context).primaryColor,
                          passiveColor: Theme.of(context).accentColor,
                          activeLeading: FontAwesomeIcons.peopleArrows,
                          isActive: _type == 1 ? true : false,
                          onTap: () {
                            if (_type != 1) {
                              setState(() {
                                _type = 1;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: _realWidth * 0.17,
                        ),

                        FeatureButton(
                            onTap: () async {
                              if (_type != null && _category != null) {
                                if (await UserModel.isCompleteData()) {
                                  // RESEARCH
                                  if (_category == 0) {
                                    // PARTNER
                                    if (_type == 0) {
                                      Navigator.pushNamed(context,
                                          RouteHandler.FIND_RESEARCH_PARTNER);
                                    }
                                    // TEAM
                                    else {
                                      Navigator.pushNamed(context,
                                          RouteHandler.FIND_RESEARCH_TEAM);
                                    }
                                  }
                                  // STARTUP
                                  else {
                                    // PARTNER
                                    if (_type == 0) {
                                      Navigator.pushNamed(context,
                                          RouteHandler.FIND_STARTUP_PARTNER);
                                    }
                                    // TEAM
                                    else {
                                      Navigator.pushNamed(context,
                                          RouteHandler.FIND_STARTUP_TEAM);
                                    }
                                  }
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, RouteHandler.UNCOMPLETED_DATA);
                                }
                              } else {
                                EasyLoading.showError(
                                    'Pilih kategori dan jenis kolaborasi terlebih dahulu',
                                    duration: Duration(seconds: 2),
                                    dismissOnTap: true);
                              }
                            },
                            title: 'Cari',
                            size: _realWidth),

                        SizedBox(
                          height: _realWidth * 0.07,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
