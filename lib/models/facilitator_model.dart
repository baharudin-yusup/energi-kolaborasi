
import 'package:flutter/material.dart';

enum FacilitatorType {
  facilitator,
  consultant,
  investor,
}

abstract class FacilitatorBaseModel {
  final String uid;
  final String accountType;

  FacilitatorBaseModel(this.uid, this.accountType);
}

// class FacilitatorModel extends FacilitatorBaseModel {
//   String _logo;
// }

class ConsultantModel extends FacilitatorBaseModel {
  String _logo;

  String _creatorId;
  String _name;
  String _institution;

  String _experience;
  String _email;
  String _phoneNumber;

  ConsultantModel({
    @required String logo,
    @required String creatorId,
    @required String name,
    @required String institution,
    @required String experience,
    @required String email,
    @required String phoneNumber,
    @required String uid,
    @required String accountType,
  }) : this._(logo, creatorId, name, institution, experience, email,
            phoneNumber, uid, accountType);

  ConsultantModel._(
      this._logo,
      this._creatorId,
      this._name,
      this._institution,
      this._experience,
      this._email,
      this._phoneNumber,
      String uid,
      String accountType)
      : super(uid, accountType);
}
