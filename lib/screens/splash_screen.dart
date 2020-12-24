import 'package:energi_kolaborasi/screens/home_screen.dart';
import 'package:energi_kolaborasi/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:energi_kolaborasi/models/user_model.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _userInitialized = false;
  bool _error = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(SplashScreen oldWidget) {
    // if (_initialized == true) {
    //   initializeUserModel();
    // }
    super.didUpdateWidget(oldWidget);
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();

      Future.delayed(Duration(milliseconds: 1500), () {
        Future.delayed(Duration(milliseconds: 1500), () async {
          FirebaseAuth.instance
              .authStateChanges()
              .listen((User user) async {
            if (user == null) {
              print('User is currently signed out!');
            } else {
              print('User is signed in!');
              await UserModel.initializeUser();
            }
          });

          setState(() {
            _initialized = true;
            _userInitialized = true;
            print('INIT SPLASH FirebaseApp $_initialized');
          });
        });
      });

      //

    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails

      print('error ==> $e');
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _error = true;
          err = e.toString();
        });
      });
    }
  }

  String err;

  void initializeUserModel() async {
    print('INIT SPLASH UserModel');

    if (_initialized) {
      Future.delayed(Duration(seconds: 2), () async {
        await UserModel.initializeUser();
      });

      // await UserModel.initializeUser();

      setState(() {
        _userInitialized = true;
      });
    } else {
      print('SPLASH ERROR!');
    }
  }

  @override
  void initState() {
    print('INIT SPLASH');
    super.initState();
    initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Text('Error, please restart the app :( {$err}'),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized || !_userInitialized) {
      return Container(
        alignment: Alignment.center,
        width: (MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.height) *
            0.7,
        height: (MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.height) *
            0.7,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/splash.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.7,
          alignment: Alignment.center,
        ),
      );
    } else {
      if (UserModel.instance == null) {
        return WelcomeScreen();
      } else {
        return HomeScreen();
      }
    }
  }
}
