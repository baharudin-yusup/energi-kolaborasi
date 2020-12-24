import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:energi_kolaborasi/models/place_model.dart';
import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:energi_kolaborasi/services/store_data.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:energi_kolaborasi/widgets/inner_header.dart';

import 'package:energi_kolaborasi/themes/light_theme.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegisterFormScreen extends StatefulWidget {
  @override
  _RegisterFormScreenState createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  OptionModel _placeModel;

  double _realWidth = 0;
  double _realHeight = 0;
  double _maxWidth = 0;

  TextEditingController _nameController;
  TextEditingController _phoneNumberController;

  String _phoneNumber;

  String _placeOfBirth;

  String _userAddress;

  String _userDistrictAddress;

  String _userCityAddress;

  String _userProvinceAddress;

  @override
  void initState() {
    super.initState();

    _placeModel = OptionModel.instance;
  }

  final double listSpec = 4.0;
  String stateText;

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

  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);

    setState(() {
      if (pickedFile != null) {
        _profilePicture = File(pickedFile.path);

        print(_profilePicture.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _calculateSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: _realHeight,
        width: _realWidth,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _realWidth * 0.05),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _realWidth * 0.2,
                  ),

                  // Header
                  Container(
                    width: _realWidth * 0.9,
                    child: Text(
                      'Informasi Pribadi',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  SizedBox(
                    height: _realWidth * 0.1,
                  ),

                  // Avatar
                  Center(
                    child: GestureDetector(
                      onTap: getImage,
                      child: _profilePicture == null
                          ? Container(
                              width: _realWidth * 0.35,
                              height: _realWidth * 0.35,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 40,
                                  ),
                                  Text('Foto Profil'),
                                ],
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: lightGrey,
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: _realWidth * 0.35,
                              height: _realWidth * 0.35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: lightGrey,
                                image: DecorationImage(
                                    image: FileImage(_profilePicture),
                                    fit: BoxFit.fill),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: _realWidth * 0.1,
                  ),

                  // Name
                  Text(
                    'Nama Lengkap',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: _realWidth * 0.02,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: lightGrey,
                      border: InputBorder.none,
                      filled: true,
                      // isDense: true,
                    ),
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Mohon isi nama lengkap Anda';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _name = value;
                      print(_name);
                      print(_nameController.text);
                    },
                    onSaved: (newValue) {
                      _name = newValue;
                      print(_name);
                      _nameController.text = newValue;
                      print(_nameController.text);
                      print(newValue);
                    },
                  ),
                  SizedBox(
                    height: _realWidth * 0.08,
                  ),

                  // POB Form
                  Text('Tempat Lahir',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: _realWidth * 0.03,
                  ),
                  SearchableDropdown.single(
                    items: _placeModel.cityList,
                    value: _placeOfBirth,
                    hint: "Pilih Kota/Kabupaten Kelahiran",
                    searchHint: "Pilih Kota/Kabupaten Kelahiran",
                    onChanged: (value) {
                      setState(() {
                        _placeOfBirth = value;
                        print(_placeOfBirth);
                      });
                    },
                    isExpanded: true,
                    isCaseSensitiveSearch: false,
                  ),
                  SizedBox(
                    height: _realWidth * 0.08,
                  ),

                  // DOB Form
                  Text('Tanggal Lahir',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: _realWidth * 0.03,
                  ),
                  _dobPicker(),
                  SizedBox(
                    height: _realWidth * 0.08,
                  ),

                  // Phone Number
                  Text(
                    'Nomor Handphone',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: _realWidth * 0.03,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: lightGrey,
                      prefixText: '+62',
                      border: InputBorder.none,
                      filled: true,
                      // isDense: true,
                    ),
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Mohon isi nama lengkap Anda';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _phoneNumber = value;
                      print(_phoneNumber);
                    },
                    onSaved: (newValue) {
                      _phoneNumber = newValue;
                    },
                  ),
                  SizedBox(
                    height: _realWidth * 0.18,
                  ),

                  // Address Header
                  Container(
                    width: _realWidth * 0.9,
                    child: Text(
                      'Alamat',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  SizedBox(
                    height: _realWidth * 0.1,
                  ),

                  // Province Form
                  Text('Provinsi',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: _realWidth * 0.03,
                  ),
                  SearchableDropdown.single(
                    items: _placeModel.cityList,
                    value: _userProvinceAddress,
                    hint: "Pilih Provinsi",
                    searchHint: "Pilih Provinsi",
                    onChanged: (value) {
                      setState(() {
                        _userProvinceAddress = value;
                        print(_userProvinceAddress);
                      });
                    },
                    isExpanded: true,
                    isCaseSensitiveSearch: false,
                  ),
                  SizedBox(
                    height: _realWidth * 0.08,
                  ),

                  // City Form
                  Text('Kabupaten/Kota',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: _realWidth * 0.03,
                  ),
                  SearchableDropdown.single(
                    items: _placeModel.cityList,
                    value: _userCityAddress,
                    hint: "Pilih Kota/Kabupaten",
                    searchHint: "Pilih Kota/Kabupaten",
                    onChanged: (value) {
                      setState(() {
                        _userCityAddress = value;
                        print(_userCityAddress);
                      });
                    },
                    isExpanded: true,
                    isCaseSensitiveSearch: false,
                  ),
                  SizedBox(
                    height: _realWidth * 0.08,
                  ),

                  // District Form
                  Text('Kecamatan',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: _realWidth * 0.03,
                  ),
                  SearchableDropdown.single(
                    items: _placeModel.districtList,
                    value: _userDistrictAddress,
                    hint: "Pilih Kecamatan",
                    searchHint: "Pilih Kecamatan",
                    onChanged: (value) {
                      setState(() {
                        _userDistrictAddress = value;
                        print(_userDistrictAddress);
                      });
                    },
                    isExpanded: true,
                    isCaseSensitiveSearch: false,
                  ),
                  SizedBox(
                    height: _realWidth * 0.08,
                  ),

                  // Address Form
                  Text(
                    'Alamat',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: _realWidth * 0.02,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: lightGrey,
                      border: InputBorder.none,
                      filled: true,
                      // isDense: true,
                    ),
                    keyboardType: TextInputType.streetAddress,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Mohon isi Alamat Anda';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _userAddress = value;
                      print(_userAddress);
                    },
                    onSaved: (newValue) {
                      _userAddress = newValue;
                      print(_userAddress);
                      print(_userAddress);
                    },
                  ),
                  SizedBox(
                    height: _realWidth * 0.08,
                  ),

                  // Submit Button
                  Container(
                    width: _realWidth * 0.9,
                    height: _realWidth * 0.13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: RaisedButton(
                      elevation: 0.0,
                      color: Colors.green,
                      child: coloredText('Submit', context),
                      onPressed: () async {
                        EasyLoading.show(
                            status: 'Mengunggah data', dismissOnTap: true);

                        var user = FirebaseAuth.instance.currentUser;

                        // String profileURL = await uploadFile(user.uid,
                        //     UserModel.PROFILE_PICTURE, _profilePicture.path);

                        await setUserData(uid: user.uid, data: {
                          UserModel.NAME: _name,
                          UserModel.POB: _placeOfBirth,
                          UserModel.DOB: _dateOfBirth,
                          UserModel.EMAIL: user.email,
                          UserModel.PHONE_NUMBER: '+62' + _phoneNumber,
                          UserModel.FIRST_TIME: false,
                          // UserModel.PROFILE_PICTURE: profileURL,
                        });

                        EasyLoading.dismiss();

                        Navigator.pushReplacementNamed(
                            context, RouteHandler.SUCCESS);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _name;

  File _profilePicture;
  bool _isAlreadyPickDOB = false;
  DateTime _dateOfBirth;

  showPickerDate(BuildContext context) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(),
        title: Text("Tanggal Lahir"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          DateTime userPick = (picker.adapter as DateTimePickerAdapter).value;
          _dateOfBirth = DateTime(
            userPick.year,
            userPick.month,
            userPick.day,
          );

          setState(() {
            _isAlreadyPickDOB = true;
          });
        }).showDialog(context);
  }

  Widget _nameFormField() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0), // shadow direction: bottom right
          )
        ],
      ),
      width: _maxWidth,
      height: _maxWidth / 6,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintStyle: Theme.of(context).textTheme.bodyText2,
            hintText: 'Masukkan nama lengkap Anda',
            border: InputBorder.none,
          ),
          maxLines: 1,
          onChanged: (value) => _userName = value,
          onSaved: (newValue) => _userName = newValue,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText1,
          maxLength: 30,
          autocorrect: false,
          validator: (value) {
            Pattern pattern = r'[A-Za-z]';
            RegExp regExp = RegExp(pattern);
            if (!regExp.hasMatch(value)) {
              return 'Nama harus huruf';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  String _userName;

  Widget _dobPicker() {

    bool isWeb = true;

    if (!isWeb) {
      // return Container(
      //   width: _maxWidth,
      //   height: _realWidth * 0.1,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(20.0),
      //     ),
      //   ),
      //   child: RaisedButton(
      //     elevation: 0.0,
      //     color: lightGrey,
      //     child: Text(
      //       _isAlreadyPickDOB
      //           ? '${_dateOfBirth.day}/${_dateOfBirth.month}/${_dateOfBirth.year}'
      //           : 'Tanggal Lahir',
      //       textAlign: TextAlign.start,
      //     ),
      //     onPressed: () {
      //       showPickerDate(context);
      //     },
      //   ),
      // );
      return SizedBox();
    } else {
      return TextFormField(
        decoration: InputDecoration(
          fillColor: lightGrey,
          border: InputBorder.none,
          filled: true,
          hintText: 'DD/MM/YYYY'
          // isDense: true,
        ),
        keyboardType: TextInputType.name,
        autocorrect: false,
        validator: (value) {
          if (value == null || value == '') {
            return 'Mohon isi tanggal lahir Anda';
          }
          return null;
        },
        onChanged: (value) {
          _dateOfBirth = DateTime(int.parse(value.substring(6, 10)), int.parse(value.substring(3, 5)), int.parse(value.substring(0, 2)));
          print(_dateOfBirth);
        },
        onSaved: (newValue) {
          _dateOfBirth = DateTime(int.parse(newValue.substring(6, 10)), int.parse(newValue.substring(3, 5)), int.parse(newValue.substring(0, 2)));
          print(_dateOfBirth);
        },
      );
  }
  }
}
