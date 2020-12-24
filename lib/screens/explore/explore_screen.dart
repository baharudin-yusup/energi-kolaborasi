import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:energi_kolaborasi/widgets/feature_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fsearch/fsearch.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class ExploreScreen extends StatefulWidget {
  final String title = 'Explore';

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {


  @override
  void initState() {

    print('INIT [${widget.title}]');
    _initUser();

    super.initState();
  }

  bool _initialized = false;
  bool _isCompleted;
  Future<void> _initUser() async {
    bool isCompletedTemp =
    await UserModel.isCompleteData();


    Future.delayed(Duration(seconds: 2), (){
      setState(() {
        _initialized = true;
        _isCompleted = isCompletedTemp;
      });
    });


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


  void dialog(BuildContext context) {
    _initialized = false;
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(
          'Lengkapi Informasi Profil Anda',
          style: Theme.of(context).textTheme.headline6,
        ),
        content: Text('Apakah Anda ingin melengkapinya sekarang?'),
        actions: [
          FlatButton(
            child: Text('Lain Kali'),
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
              });
            },
          ),
          FlatButton(
              child: Text('OK'),
              onPressed: () {

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (kIsWeb) {
                    return Navigator.pushNamed(context, RouteHandler.PROFILE_APPLICANT_WEB);
                  } else {
                    return Navigator.pushNamed(context, RouteHandler.PROFILE_APPLICANT);
                  }
                });

              }

          ),
        ],
      );
    },);
  }

  @override
  Widget build(BuildContext context) {

    if (_initialized && (!_isCompleted ?? false)) {
      Future.delayed(Duration.zero, ()=> dialog(context));
    }

    return SingleChildScrollView(
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

                SizedBox(
                  height: _realHeight * 0.03,
                ),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  width: _realWidth * 0.9,
                  height: _realHeight * 0.06,
                  child: FSearch(
                    hints: [
                      'Cari Projek',
                    ],
                    hintStyle: TextStyle(color: Colors.black54),
                    width: _realHeight * 0.06,
                    height: _realHeight * 0.06,
                    backgroundColor: Colors.white,
                    style: TextStyle(
                        fontSize: 16.0, height: 1.0, color: Colors.grey),
                    margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 9.0),
                    padding: EdgeInsets.only(
                        left: 6.0, right: 6.0, top: 3.0, bottom: 3.0),
                    prefixes: [
                      const SizedBox(width: 6.0),
                      Icon(
                        Icons.search,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 3.0)
                    ],

                    /// 点击键盘搜索时触发
                    ///
                    /// Fired when you click on the keyboard to search
                    onSearch: (value) {
                      setState(() {
                        // searching1 = true;
                      });
                    },
                  ),
                ),

                SizedBox(
                  height: _realHeight * 0.03,
                ),

                // Create Project
                featureBanner(
                  background: AssetImage('assets/images/explore-create.jpg'),
                  title: 'Buat Proyek Kamu Sekarang',
                  icon: Icons.circle,
                  size: FeatureSize.big,
                  baseWidth: _realWidth,
                  baseHeight: _realHeight,
                  context: context,
                  route: RouteHandler.CREATE_PROJECT_OPTION,
                ),

                SizedBox(
                  height: _realHeight * 0.03,
                ),

                // Features
                Container(
                  width: _realWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      featureButton(
                          icon: FaIcon(FontAwesomeIcons.microscope).icon,
                          title: 'Riset',
                          baseWidth: _realWidth,
                          baseHeight: _realHeight,
                          context: context,
                          route: RouteHandler.RESEARCH),
                      featureButton(
                          icon: FaIcon(FontAwesomeIcons.servicestack).icon,
                          title: 'Konsultasi',
                          baseWidth: _realWidth,
                          baseHeight: _realHeight,
                          context: context,
                          route: RouteHandler.CONSULTATION),
                      featureButton(
                          icon: FaIcon(FontAwesomeIcons.dollarSign).icon,
                          title: 'Pendanaan',
                          baseWidth: _realWidth,
                          baseHeight: _realHeight,
                          context: context,
                          route: RouteHandler.FUNDING),
                      featureButton(
                          icon: FaIcon(FontAwesomeIcons.kickstarter).icon,
                          title: 'Startup',
                          baseWidth: _realWidth,
                          baseHeight: _realHeight,
                          context: context,
                          route: RouteHandler.STARTUP),
                    ],
                  ),
                ),

                SizedBox(
                  height: _realHeight * 0.03,
                ),

                featureBanner(
                  background: AssetImage('assets/images/explore-progress.jpg'),
                  title: 'Cek Progress Projek Kamu Disini!',
                  icon: Icons.circle,
                  baseWidth: _realWidth,
                  baseHeight: _realHeight,
                  size: FeatureSize.medium,
                  context: context,
                  route: RouteHandler.PROGRESS,
                ),

                SizedBox(
                  height: _realHeight * 0.03,
                ),

                // Check Collaboration Project
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(20.0),
                //     ),
                //     color: Colors.black54,
                //   ),
                //   width: _realWidth * 0.9,
                //   height: _realHeight * 0.2,
                // ),

                featureBanner(
                    background:
                        AssetImage('assets/images/explore-collaboration.jpg'),
                    title: 'Projek Kolaborasi',
                    icon: Icons.circle,
                    baseWidth: _realWidth,
                    baseHeight: _realHeight,
                    size: FeatureSize.medium,
                    context: context,
                    route: RouteHandler.COLLABORATION_OPTION),

                SizedBox(
                  height: _realHeight * 0.06,
                ),
              ],
            ),
          ),
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
