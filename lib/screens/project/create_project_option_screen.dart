import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:energi_kolaborasi/utils/function.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:energi_kolaborasi/utils/space.dart';
import 'package:energi_kolaborasi/widgets/choice_tile.dart';
import 'package:energi_kolaborasi/widgets/header_image.dart';
import 'package:energi_kolaborasi/widgets/inner_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateProjectOptionScreen extends StatefulWidget {
  final String title = 'Buat Suatu Proyek';

  @override
  _CreateProjectOptionScreenState createState() =>
      _CreateProjectOptionScreenState();
}

class _CreateProjectOptionScreenState extends State<CreateProjectOptionScreen> {

  double _realWidth;
  double _realHeight;
  double _mediaWidth;
  double _mediaHeight;
  Space _height;
  bool _perfectRatio = true;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _checkResolution();

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      //Header
                      SizedBox(height: _height.height4,),
                      HeaderImage(
                        title: 'Halaman Pemilihan Proyek',
                        size: _realWidth,
                        image: AssetImage('assets/images/collaboration.jpg'),
                        subtitle: 'Semua Mimpimu dimulai dari Sini',
                      ),
                      SizedBox(height: _height.height3,),

                      SizedBox(
                        height: _realWidth * 0.1,
                      ),

                      Container(
                        width: _realWidth * 0.9,
                        child: Text(
                          'Pilih Bidang',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,),
                      ),
                      SizedBox(
                        height: _height.height4,
                      ),

                      ChoiceTile(
                        size: _realWidth,
                        activeTitle: 'Riset',
                        passiveColor: Theme.of(context).primaryColor,
                        activeLeading: FontAwesomeIcons.microscope,
                        isActive: false,
                        onTap: () => Navigator.pushNamed(context, RouteHandler.RESEARCH_CREATE_PROJECT),),
                      SizedBox(
                        height: _height.height5,
                      ),

                      ChoiceTile(
                        size: _realWidth,
                        activeTitle: 'Startup',
                        passiveColor: Theme.of(context).primaryColor,
                        activeLeading: FontAwesomeIcons.rocket,
                        isActive: false,
                        onTap: () => Navigator.pushNamed(context, RouteHandler.STARTUP_CREATE_PROJECT),
                      ),

                      SizedBox(
                        height: _height.height3,
                      ),

                      Container(
                        width: _realWidth * 0.9,
                        child: Text(
                          'Atau Menjadi Fasilitator',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,),
                      ),
                      SizedBox(
                        height: _height.height4,
                      ),

                      ChoiceTile(
                        size: _realWidth,
                        activeTitle: 'Konsultan',
                        passiveColor: Theme.of(context).primaryColor,
                        activeLeading: Icons.person_pin,
                        isActive: false,
                        onTap: () {
                          int status = UserModel.instance.consultantAccountStatus;

                          if ((status ?? -1) == -1) {
                            return Navigator.pushNamed(context, RouteHandler.CONSULTANT_REGISTER);
                          }

                          return Navigator.pushNamed(context, RouteHandler.PROFILE_CONSULTANT);
                        },
                      ),

                      SizedBox(
                        height: _realWidth * 0.02,
                      ),

                      ChoiceTile(
                        size: _realWidth,
                        activeTitle: 'Pendana',
                        passiveColor: Theme.of(context).primaryColor,
                        activeLeading: FontAwesomeIcons.moneyCheckAlt,
                        isActive: false,
                        onTap: () {
                          int status = UserModel.instance.investorAccountStatus;

                          if ((status ?? -1) == -1) {
                            return Navigator.pushNamed(context, RouteHandler.INVESTOR_REGISTER);
                          }

                          return Navigator.pushNamed(context, RouteHandler.PROFILE_INVESTOR);

                        },
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
        _height = Space(size: _realWidth);
      });
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   _calculateSize(context);
  //   return Scaffold(
  //     appBar: AppBar(
  //       // iconTheme: IconThemeData(
  //       //   color: Colors.black54,
  //       // ),
  //       backgroundColor: Colors.white,
  //       title: Text(
  //         widget.title,
  //         style: Theme
  //             .of(context)
  //             .textTheme
  //             .headline6,
  //       ),
  //       centerTitle: true,
  //     ),
  //     body: Container(
  //       alignment: Alignment.topCenter,
  //       width: _realWidth,
  //       height: _realHeight,
  //       child: SingleChildScrollView(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             SizedBox(
  //               height: _realWidth * 0.1,
  //             ),
  //
  //             Container(
  //               width: _realWidth * 0.9,
  //               child: Text(
  //                 'Pilih Bidang',
  //                 style: Theme
  //                     .of(context)
  //                     .textTheme
  //                     .headline4,),
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.05,
  //             ),
  //
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                   horizontal: _realWidth * 0.05,
  //                   vertical: _realWidth * 0.01),
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 height: _realWidth * 0.22,
  //                 decoration: BoxDecoration(
  //                   borderRadius:
  //                   BorderRadius.all(Radius.circular(20.0)),
  //                   color: Theme
  //                       .of(context)
  //                       .primaryColor,
  //                 ),
  //                 child: ListTile(
  //                   leading: Icon(
  //                     Icons.circle,
  //                     color: Colors.white,
  //                     size: _realWidth * 0.1,
  //                   ),
  //                   title: coloredText('Riset', context, big: true),
  //                   trailing: Icon(
  //                     Icons.arrow_forward_ios_rounded,
  //                     color: Colors.white,
  //                   ),
  //                   onTap: () {
  //                     Navigator.pushNamed(
  //                         context, RouteHandler.PROJECT_REGISTER,
  //                         arguments: false);
  //                   },
  //                 ),
  //               ),
  //             ),
  //
  //             SizedBox(
  //               height: _realWidth * 0.02,
  //             ),
  //
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                   horizontal: _realWidth * 0.05,
  //                   vertical: _realWidth * 0.01),
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 height: _realWidth * 0.22,
  //                 decoration: BoxDecoration(
  //                   borderRadius:
  //                   BorderRadius.all(Radius.circular(20.0)),
  //                   color: Theme
  //                       .of(context)
  //                       .primaryColor,
  //                 ),
  //                 child: ListTile(
  //                   leading: Icon(
  //                     Icons.circle,
  //                     color: Colors.white,
  //                     size: _realWidth * 0.1,
  //                   ),
  //                   title: coloredText('Startup', context, big: true),
  //                   trailing: Icon(
  //                     Icons.arrow_forward_ios_rounded,
  //                     color: Colors.white,
  //                   ),
  //                   onTap: () =>
  //                       Navigator.pushNamed(
  //                           context, RouteHandler.PROJECT_REGISTER,
  //                           arguments: true)
  //                   ,
  //                 ),
  //               ),
  //             ),
  //
  //             SizedBox(
  //               height: _realWidth * 0.1,
  //             ),
  //
  //             Container(
  //               width: _realWidth * 0.9,
  //               child: Text(
  //                 'Atau Menjadi Fasilitator',
  //                 style: Theme
  //                     .of(context)
  //                     .textTheme
  //                     .headline4,),
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.05,
  //             ),
  //
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                   horizontal: _realWidth * 0.05,
  //                   vertical: _realWidth * 0.01),
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 height: _realWidth * 0.22,
  //                 decoration: BoxDecoration(
  //                   borderRadius:
  //                   BorderRadius.all(Radius.circular(20.0)),
  //                   color: Theme
  //                       .of(context)
  //                       .primaryColor,
  //                 ),
  //                 child: ListTile(
  //                   leading: Icon(
  //                     Icons.circle,
  //                     color: Colors.white,
  //                     size: _realWidth * 0.1,
  //                   ),
  //                   title: coloredText('Konsultan', context, big: true),
  //                   trailing: Icon(
  //                     Icons.arrow_forward_ios_rounded,
  //                     color: Colors.white,
  //                   ),
  //                   onTap: () {},
  //                 ),
  //               ),
  //             ),
  //
  //             SizedBox(
  //               height: _realWidth * 0.02,
  //             ),
  //
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                   horizontal: _realWidth * 0.05,
  //                   vertical: _realWidth * 0.01),
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 height: _realWidth * 0.22,
  //                 decoration: BoxDecoration(
  //                   borderRadius:
  //                   BorderRadius.all(Radius.circular(20.0)),
  //                   color: Theme
  //                       .of(context)
  //                       .primaryColor,
  //                 ),
  //                 child: ListTile(
  //                   leading: Icon(
  //                     Icons.circle,
  //                     color: Colors.white,
  //                     size: _realWidth * 0.1,
  //                   ),
  //                   title: coloredText('Pendana', context, big: true),
  //                   trailing: Icon(
  //                     Icons.arrow_forward_ios_rounded,
  //                     color: Colors.white,
  //                   ),
  //                   onTap: () {},
  //                 ),
  //               ),
  //             ),
  //
  //             SizedBox(
  //               height: _realWidth * 0.1,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
