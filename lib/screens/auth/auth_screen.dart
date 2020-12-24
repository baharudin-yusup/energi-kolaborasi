import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:energi_kolaborasi/services/store_data.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/flutter_login.dart';

// TODO: TAMBAH FORM PEKERJAAN

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );

      await UserModel.initializeUser();

      Navigator.pushReplacementNamed(context, RouteHandler.HOME);

      // DocumentSnapshot documentSnapshot =
      //     await getUserData(userCredential.user.uid);
      //
      // if (documentSnapshot.data()[UserModel.FIRST_TIME]) {
      //   Navigator.pushReplacementNamed(context, RouteHandler.FIRST_CREATE);
      // } else {
      //   Navigator.pushReplacementNamed(context, RouteHandler.HOME);
      // }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'Wrong password provided for that user.';
      }
    }

    return null;
  }

  Future<String> _recoverPassword(String email) async {
    print('Name: $email');

    final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

    print('Check started');
    if (list.length > 0) {
      print('LENGG ' + list.length.toString());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      return null;
    } else {
      return 'Tidak ada user yang terdaftar dengan email $email';
    }
  }

  Future<String> _signUp(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data.name, password: data.password);
      if (userCredential != null) {
        if (!userCredential.user.emailVerified) {
          print('Send EV');
        }

        setUserData(uid: userCredential.user.uid, data: {
          UserModel.FIRST_TIME: true,
          UserModel.ADDITIONAL_ACCOUNT: {
            UserModel.CONSULTANT: -1,
            UserModel.INVESTOR: -1
          }
        });

        Future.delayed(Duration(milliseconds: 1500), () {
          Future.delayed(Duration(milliseconds: 1500), () async {
            await UserModel.initializeUser();

            Navigator.pushReplacementNamed(context, RouteHandler.HOME);
          });
        });
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);

      return '${e.toString()}';
    }

    return 'Error!';
  }

  double _realWidth = 0;
  double _realHeight = 0;
  double _maxWidth = 0;

  void _calculateSize(BuildContext context) {
    // Resolution 16:9

    if (MediaQuery.of(context).size.width <
        MediaQuery.of(context).size.height) {
      _realWidth = MediaQuery.of(context).size.width;
      _realHeight = MediaQuery.of(context).size.height;
    } else {
      _realHeight = MediaQuery.of(context).size.height;
      _realWidth = _realHeight * (9 / 16);
    }

    _maxWidth = _realWidth * 0.9;
  }

  @override
  Widget build(BuildContext context) {
    _calculateSize(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            color: Theme.of(context).primaryColor,
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                    color: Colors.transparent,
                    width: _realWidth,
                    height: _realHeight * 0.9,
                    child: FlutterLogin(
                      theme: LoginTheme(
                        titleStyle: TextStyle(fontSize: 0.0),
                      ),
                      title: ' ',
                      logo: 'assets/icons/logo-white.png',
                      onLogin: _authUser,
                      onSignup: _signUp,
                      onSubmitAnimationCompleted: () {
                        Navigator.pushReplacementNamed(
                            context, RouteHandler.HOME);
                      },
                      onRecoverPassword: _recoverPassword,
                    )),
                Container(
                  alignment: Alignment.center,
                  width: _realWidth,
                  height: _realHeight * 0.1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/esdm-logo.png'),
                        width: _realWidth * 0.077,
                        height: _realWidth * 0.077,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Text(
                        'Energi Kolaborasi by Kementrian ESDM',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
