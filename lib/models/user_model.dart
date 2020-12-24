import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energi_kolaborasi/models/place_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {

  static const String FILE_NAME = 'file_name';
  static const String FILE_URL = 'file_url';

  // Investor
  static const String INVESTOR_ID_URL = 'investor_id_url';

  // Consultant
  static const String CONSULTANT_ID_URL = 'consultant_id_url';

  static const String ERROR_MESSAGE = 'Isi data terlebih dahulu';

  static const String EMAIL = 'email';
  static const String EMAIL_VERIFIED = 'email_verified';
  static const String NAME = 'name';
  static const String PHONE_NUMBER = 'phone_number';
  static const String PROFILE_PICTURE = 'profile_picture';
  static const String UID = 'uid';

  static const String DOB = 'date_of_birth';
  static const String FIRST_TIME = 'first_time';
  static const String JOB = 'job';
  static const String POB = 'place_of_birth';
  static const String ROLE = 'role';
  static const String CURRENT_ADDRESS = 'current_address';

  static const String ADDITIONAL_ACCOUNT = 'additional_account';
  static const String INVESTOR = 'investor';
  static const String CONSULTANT = 'consultant';

  // Investor
  Map<String, String> _investorIdFile;

  // Consultant
  Map<String, String> _consultantIdFile;


  UserModel._();

  static UserModel _instance;

  static Future<UserModel> initializeUser() async {
    if (_instance == null) {
      print('INIT UserModel Started');

      UserModel._instance = UserModel._();

      UserModel._instance._user = FirebaseAuth.instance.currentUser;

      if (_instance._user == null) {
        UserModel._instance = null;
        print('INIT UserModel Cancelled, no user login');
        return null;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserModel._instance._user.uid)
          .get()
          .then((snapshot) {

        if (snapshot.exists) {
          UserModel._instance._dateOfBirth = snapshot.data()[UserModel.DOB] != null ?
              (snapshot.data()[UserModel.DOB] as Timestamp).toDate() : null;
          UserModel._instance._firstTime = snapshot.data()[UserModel.FIRST_TIME] != null ?
              snapshot.data()[UserModel.FIRST_TIME] : null;
          UserModel._instance._job = snapshot.data()[UserModel.JOB] != null ? List<String>.from(snapshot.data()[UserModel.JOB]) : null;
          UserModel._instance._placeOfBirth =
              snapshot.data()[UserModel.POB] ?? null;
          UserModel._instance._role = snapshot.data()[UserModel.ROLE] ?? null;
          UserModel._instance._role = snapshot.data()[UserModel.PHONE_NUMBER] ?? null;
          UserModel._instance._currentAddress = snapshot.data()[UserModel.CURRENT_ADDRESS] != null ?
              Map<String, String>.from(snapshot.data()[UserModel.CURRENT_ADDRESS]) : null;
          UserModel._instance._additionalAccount = snapshot.data()[UserModel.ADDITIONAL_ACCOUNT] != null ?
          Map<String, int>.from(snapshot.data()[UserModel.ADDITIONAL_ACCOUNT]) : null;

          if (UserModel._instance._additionalAccount != null) {

            if (UserModel._instance._additionalAccount[UserModel.CONSULTANT] > -1) {
              UserModel._instance._consultantIdFile = snapshot.data()[UserModel.CONSULTANT_ID_URL] != null ?
              Map<String, String>.from(snapshot.data()[UserModel.CONSULTANT_ID_URL]) : null;
            }

            if (UserModel._instance._additionalAccount[UserModel.INVESTOR] > -1) {
              UserModel._instance._consultantIdFile = snapshot.data()[UserModel.INVESTOR_ID_URL] != null ?
              Map<String, String>.from(snapshot.data()[UserModel.INVESTOR_ID_URL]) : null;
            }

          }

        } else {
          print('Error No User Data');
        }
      });
    }

    print('No need INIT UserModel');
    return null;
  }

  static UserModel get instance => UserModel._instance;


  User _user;


  static Future<bool> isCompleteData() async {

    return await FirebaseFirestore
        .instance
        .collection('users')
        .doc(_instance.uid)
        .get()
        // ignore: missing_return
        .then((value) {
      // ignore: missing_return
      if (value.exists) {

        Map<String, dynamic> data = value.data();

        if (_instance.name != null && data[PHONE_NUMBER] != null) {
          return true;
        }

        return false;
      }
    });

  }

  DateTime _dateOfBirth;
  bool _firstTime;
  List<String> _job;
  String _placeOfBirth;
  String _role;
  String _phoneNumber;
  Map<String, String> _currentAddress;
  Map<String, int> _additionalAccount;

  int get investorAccountStatus => _additionalAccount[UserModel.INVESTOR];
  int get consultantAccountStatus => _additionalAccount[UserModel.CONSULTANT];

  String get uid => FirebaseAuth.instance.currentUser.uid;

  String get email => FirebaseAuth.instance.currentUser.email;

  bool get emailVerified => FirebaseAuth.instance.currentUser.emailVerified;

  String get name =>
      FirebaseAuth.instance.currentUser.displayName ?? ERROR_MESSAGE;

  String get phoneNumber =>
      _phoneNumber;

  String get profilePicture => FirebaseAuth.instance.currentUser.photoURL;

  DateTime get dateOfBirth => _dateOfBirth;

  bool get firstTime => _firstTime;

  List<String> get job => _job ?? null;

  String get placeOfBirth => _placeOfBirth ?? ERROR_MESSAGE;

  String get role => _role ?? ERROR_MESSAGE;

  Map<String, String> get currentAddress {
    if (_currentAddress != null)
      return _currentAddress;
    else
      return null;
  }

  dynamic getSpecificData(String key) async {
    await FirebaseFirestore
        .instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        return snapshot.data()[key];
      }
    });
  }

  Future<void> updateData({Map<String, dynamic> authData = const {}, Map<String,
      dynamic> firestoreData = const {}}) async {
    // TODO : Add validator key
    if (firestoreData.isNotEmpty) {
      await FirebaseFirestore
          .instance
          .collection('users')
          .doc(uid)
          .update(firestoreData)
          .then((value) {
            _internalUpdate(firestoreData);
      });
    }

    if (authData.isNotEmpty) {
      // TODO: Later
      authData.forEach((key, value) {
        switch(key) {
          case UserModel.PROFILE_PICTURE:
            UserModel._instance._user.updateProfile(photoURL: value);
        }
      });

    }
  }

  Future<void> update(String param) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserModel._instance._user.uid)
        .get()
        .then((snapshot) {
      switch (param) {
        case DOB:
          UserModel._instance._dateOfBirth =
              (snapshot.data()[UserModel.DOB] as Timestamp).toDate() ?? null;
          break;
        case FIRST_TIME:
          UserModel._instance._firstTime =
              snapshot.data()[UserModel.JOB] ?? null;
          break;
        case JOB:
          UserModel._instance._job = snapshot.data()[UserModel.JOB] ?? null;
          break;
        case POB:
          UserModel._instance._placeOfBirth =
              snapshot.data()[UserModel.POB] ?? null;
          break;
        case ROLE:
          UserModel._instance._role = snapshot.data()[UserModel.ROLE] ?? null;
          break;
        case JOB:
          UserModel._instance._job = snapshot.data()[UserModel.JOB] ?? null;
          break;
        case CURRENT_ADDRESS:

          UserModel._instance._currentAddress = Map<String, String>.from(snapshot.data()[UserModel.CURRENT_ADDRESS]);

          break;
      }
    });
  }

  void _internalUpdate(Map<String, dynamic> firestoreData) {
    firestoreData.forEach((key, value) {
      switch(key) {
        case DOB:
          UserModel._instance._dateOfBirth = value;
          break;
        case FIRST_TIME:
          UserModel._instance._firstTime = value;
          break;
        case JOB:
          UserModel._instance._job  = value;
          break;
        case POB:
          UserModel._instance._placeOfBirth = value;
          break;
        case ROLE:
          UserModel._instance._role  = value;
          break;
        case PHONE_NUMBER:
          UserModel._instance._phoneNumber  = value;
          break;
        case CURRENT_ADDRESS:

          UserModel._instance._currentAddress = Map<String, String>.from(value);

          break;
      }
    });
  }

}
