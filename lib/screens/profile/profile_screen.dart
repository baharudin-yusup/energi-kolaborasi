import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energi_kolaborasi/models/place_model.dart';
import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:energi_kolaborasi/utils/function.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:energi_kolaborasi/widgets/abstract_circle_avatar.dart';
import 'package:energi_kolaborasi/widgets/abstract_tile.dart';
import 'package:energi_kolaborasi/widgets/inner_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProfileScreen extends StatefulWidget {
  final String title = 'Profile Screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int _tab = 0;

  bool _hasConsultantAccount = false;
  bool _hasInvestorAccount = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel _user = UserModel.instance;
  bool _emailStatus = FirebaseAuth.instance.currentUser.emailVerified;

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
              body: SingleChildScrollView(
                child: Container(
                  width: _realWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Upper Avatar Banner
                      Container(
                        width: _realWidth,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/profile-windmill.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                  BlendMode.dstATop),
                            ),
                            color: Theme.of(context).primaryColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: _realHeight * 0.07,
                            ),

                            AbstractAvatar(
                              size: _realWidth,
                              url: _user.profilePicture,
                            ),
                            SizedBox(
                              height: _realHeight * 0.02,
                            ),

                            // User Full Name
                            Text(
                              _user.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(
                              height: _realHeight * 0.009,
                            ),

                            // User Role
                            Text(
                              _jobValueGetter(0),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(
                              height: _realHeight * 0.006,
                            ),

                            // Location
                            Text(
                              _user.currentAddress != null
                                  ? (_user.currentAddress[OptionModel.CITY] !=
                                              null &&
                                          _user.currentAddress[
                                                  OptionModel.PROVINCE] !=
                                              null
                                      ? '${_user.currentAddress[OptionModel.CITY]}, ${_user.currentAddress[OptionModel.PROVINCE]}'
                                      : '')
                                  : '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _realHeight * 0.03,
                      ),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: _realWidth * 0.05),
                        child: Column(
                          children: [
                            // Tab Bar
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                color: Color(0xffDCDCDC),
                              ),
                              width: _realWidth,
                              height: _realHeight * 0.05,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        'Personal',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
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
                                        'History',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: _realHeight * 0.05,
                            ),

                            _initialized ? _content() : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _realHeight * 0.2,
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

  Widget _content() {

    switch(_tab) {
      case 0:
        return Column(
          children: [
            // Email
            AbstractTile(size: _realWidth, title: auth.currentUser.emailVerified
                ? 'Email Sudah Diverifiaksi'
                : 'Email Belum Diverifikasi', onTap: _showEmailVerificationDialog,),
            SizedBox(height: _realWidth * 0.03,),

            // Edit Profile
            AbstractTile(size: _realWidth, title: 'Edit Informasi Akun', onTap: () {
              if (kIsWeb) {
                return Navigator.pushNamed(
                    context,
                    RouteHandler
                        .PROFILE_APPLICANT_WEB);
              } else {
                return Navigator.pushNamed(
                    context,
                    RouteHandler.PROFILE_APPLICANT);
              }
            },),
            SizedBox(height: _realWidth * 0.03,),

            // Edit Consultant Profile
            AbstractTile(size: _realWidth, title: 'Edit Akun Konsultan', show: _hasConsultantAccount,),
            _hasConsultantAccount ? SizedBox(height: _realWidth * 0.03,) :  SizedBox(),

            // Edit Investor Profile
            AbstractTile(size: _realWidth, title: 'Edit Akun Investor', show: _hasInvestorAccount,),
            _hasInvestorAccount ? SizedBox(height: _realWidth * 0.03,) :  SizedBox(),

            // Logout
            AbstractTile(size: _realWidth, title: 'Keluar', onTap: _showLogoutDialog,),
            SizedBox(height: _realWidth * 0.03,),
          ],
        );
        break;
      default:
        return SizedBox();
        break;
    }
  }

  Future<void> _initializeData() async {

    bool consultant;
    bool investor;

    await FirebaseFirestore
        .instance
    .collection('users')
    .doc(_user.uid)
    .get()
    .then((value) {

      if (value.exists) {

        if (value.data()['additional_account'] != null) {

          Map<String, int> additionalAccount =  Map<String, int>.from(value.data()['additional_account']);


          consultant = additionalAccount['consultant'] != null ? (additionalAccount['consultant'] >= 0 ? true : false) : false;
          investor = additionalAccount['investor'] != null ? (additionalAccount['investor'] >= 0 ? true : false) : false;
        } else {
          consultant = false;
          investor = false;
        }

      }
      else {
        consultant = false;
        investor = false;
      }


    });

    if (!mounted) {
      return;
    }

    setState(() {
      _initialized = true;
      _hasConsultantAccount = consultant;
      _hasInvestorAccount = investor;
    });

  }

  String _jobValueGetter(int index) {
    if (_user.job != null) {
      if (_user.job.length >= index + 1) {
        if (_user.job[index] != null) {
          return _user.job[index];
        }
      }
    }

    return '';
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Apakah anda ingin keluar?'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Tidak'),
          ),
          FlatButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushReplacementNamed(context, RouteHandler.AUTH));
            },
            child: Text('Ya'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _showEmailVerificationDialog() async {
    if (!auth.currentUser.emailVerified) {
      print('Kirim email');
      await auth.currentUser.sendEmailVerification();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Verifikasi Email'),
          content: Text(
              'Sebuah link verifikasi email sudah dikirim ke ${auth.currentUser.email}'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } else {
      if (_emailStatus != auth.currentUser.emailVerified) {
        auth.currentUser.reload();

        print('Sudah verif');
        setState(() {
          _emailStatus = auth.currentUser.emailVerified;
        });
      }
    }
  }
}
