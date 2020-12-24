import 'dart:io';

import 'package:flutter/cupertino.dart';

class ProjectModel {

  static const String UID = 'uid';
  static const String RESEARCH_CATEGORY = 'category';
  static const String EMAIL = 'email';
  static const String INSTITUTION = 'institution';
  static const String LEVEL = 'level';
  static const String PHONE_NUMBER = 'phone_number';
  static const String TITLE = 'title';
  static const String UPLOADER = 'uploader';

  String _uid;
  String _category;
  String _email;
  String _institution;
  int _level;
  String _phoneNumber;
  String _title;
  String _uploader;

  static const String FILE_NAME = 'file_name';
  static const String FILE_URL = 'file_url';

  // Research
  static const String ABSTRACT_URL = 'abstract_url';
  static const String DESIGN_URL = 'design_url';
  static const String FINANCE_URL = 'finance_url';

  Map<String, String> _abstractFile;
  Map<String, String> _designFile;
  Map<String, String> _financeFile;

  // Startup
  static const String PROPOSAL_URL = 'proposal_url';
  static const String PITCH_DECK_URL = 'pitch_deck_url';

  Map<String, String> _proposalFile;
  Map<String, String> _pitchDeckFile;

  ProjectModel.name(
    this._uid,
    this._category,
    this._email,
    this._institution,
    this._level,
    this._phoneNumber,
    this._title,
    this._uploader, {
    Map<String, String> abstractFile,
    Map<String, String> designFile,
    Map<String, String> financeFile,
    Map<String, String> proposalFile,
    Map<String, String> pitchDeckFile,
  }) {
    this._abstractFile = abstractFile ?? null;
    this._designFile = designFile ?? null;
    this._financeFile = financeFile ?? null;
    this._proposalFile = proposalFile ?? null;
    this._pitchDeckFile = pitchDeckFile ?? null;
  }

  Map<String, String> get proposalFile => _proposalFile;

  void setFromLocal({
    @required String uid,
    @required String institution,
    @required String researchCategory,
    @required File abstractFile,
    @required File designFile,
    @required File financeFile,
  }) {}

  // Map<String, Object> toJSON() {
  //   return {
  //     UID: _uid,
  //     INSTITUTION: _institution,
  //     RESEARCH_CATEGORY: _category,
  //     ABSTRACT_URL: _abstractUrl,
  //     DESIGN_URL: _designURL,
  //     FINANCE_URL: _financeUrl,
  //   };
  // }
  //
  // Map<String, String> get financeUrl => _financeUrl;
  //
  // Map<String, String> get designURL => _designURL;
  //
  // Map<String, String> get abstractUrl => _abstractUrl;

  String get uploader => _uploader;

  String get title => _title;

  Map<String, String> get abstractFile => _abstractFile;

  String get phoneNumber => _phoneNumber;

  int get level => _level;

  String get institution => _institution;

  String get email => _email;

  String get category => _category;

  String get uid => _uid;

  Map<String, String> get designFile => _designFile;

  Map<String, String> get financeFile => _financeFile;

  Map<String, String> get pitchDeckFile => _pitchDeckFile;
}
