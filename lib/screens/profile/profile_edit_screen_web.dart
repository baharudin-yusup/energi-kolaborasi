import 'dart:io' as io;

import 'package:energi_kolaborasi/models/place_model.dart';
import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:energi_kolaborasi/services/store_data.dart';
import 'package:energi_kolaborasi/widgets/data_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileEditScreenWeb extends StatefulWidget {
  final String title = 'Edit Informasi Akun';

  @override
  _ProfileEditScreenWebState createState() => _ProfileEditScreenWebState();
}

class _ProfileEditScreenWebState extends State<ProfileEditScreenWeb> {
  UserModel _user;

  @override
  void initState() {
    super.initState();

    _init();
  }

  final _formKey = GlobalKey<FormState>();

  double _realWidth = 0;
  double _realHeight = 0;
  double _mediaWidth = 0;
  double _mediaHeight = 0;
  double _maxWidth = 0;
  bool _sameRatio = true;

  void _calculateSize(BuildContext context) {
    print(_sameRatio ? 'YA' : 'NO');

    if (kIsWeb) {
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
      if (_realHeight != MediaQuery.of(context).size.height ||
          _realWidth != MediaQuery.of(context).size.width) {
        setState(() {
          _realWidth = MediaQuery.of(context).size.width;
          _realHeight = MediaQuery.of(context).size.height;
        });
      }
    }
  }

  // // Image Controller
  // String _userAvatar;
  // File _profilePicture;
  // Future getImage() async {
  //   final pickedFile = await picker.getImage(
  //       source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _profilePicture = File(pickedFile.path);
  //
  //       print(_profilePicture.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    _calculateSize(context);

    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        color: _sameRatio ? Colors.white : Colors.black12,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: _realHeight,
              maxWidth: _maxWidth,
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _realWidth * 0.05),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _realWidth * 0.3,
                      ),
                      _nameField(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: _realWidth * 0.01, bottom: _realWidth * 0.025),
                        child: Container(
                          height: 1,
                          width: _realWidth,
                          color: Colors.grey,
                        ),
                      ),
                      InkWell(
                        child: Container(
                          width: _maxWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: _realWidth * 0.01,
                                  ),
                                  Text(
                                    _user != null ? _user.name : '...',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: _realWidth * 0.01,
                              ),
                              Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColor,
                                size: _realWidth * 0.04,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          String input = _user != null
                              ? (_user.name != UserModel.ERROR_MESSAGE
                                  ? _user.name
                                  : '')
                              : '';

                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(
                                      'Masukan nama Anda',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    content: TextField(
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: 'Masukan nama Anda disini',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) => input = value,
                                      controller: TextEditingController()
                                        ..text = input,
                                    ),
                                    actions: [
                                      FlatButton(
                                        child: Text(
                                          'Batalkan',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'Simpan',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () async {
                                          print('Set');
                                          await FirebaseAuth
                                              .instance.currentUser
                                              .updateProfile(
                                                  displayName: input);
                                          print('Ok 1');
                                          setState(() {
                                            print('new name ${_user.name}');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ));
                        },
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

  Future<void> _init() async {
    _user = await UserModel.instance;
    setState(() {
      print('Init name ${_user.name}');
    });
  }

  Widget _nameField() {
    return InkWell(
      child: Container(
        width: _maxWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: _realWidth * 0.01,
                ),
                Text(
                  _user != null ? _user.name : '...',
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
            SizedBox(
              width: _realWidth * 0.01,
            ),
            Icon(
              Icons.edit,
              color: Theme.of(context).primaryColor,
              size: _realWidth * 0.04,
            ),
          ],
        ),
      ),
      onTap: () {
        String input = _user != null
            ? (_user.name != UserModel.ERROR_MESSAGE ? _user.name : '')
            : '';

        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    'Masukan nama Anda',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  content: TextField(
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Masukan nama Anda disini',
                      hintStyle: Theme.of(context).textTheme.bodyText1,
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => input = value,
                    controller: TextEditingController()..text = input,
                  ),
                  actions: [
                    FlatButton(
                      child: Text(
                        'Batalkan',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text(
                        'Simpan',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        print('Set');
                        await FirebaseAuth.instance.currentUser
                            .updateProfile(displayName: input);
                        print('Ok 1');
                        setState(() {
                          print('new name ${_user.name}');
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
      },
    );
  }
}

class ProfileEditScreen extends StatefulWidget {
  final String title = 'Edit Informasi Akun';

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  UserModel _user;
  OptionModel _placeModel;

  var phoneNumberFormatter = MaskTextInputFormatter(
      mask: '+## ###-####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    _placeModel = OptionModel.instance;
    _user = UserModel.instance;
    super.initState();
  }

  void _init() async {
    _user = UserModel.instance;
    setState(() {
      print('Init name ${_user.name}');
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_mediaHeight != MediaQuery.of(context).size.height ||
        _mediaWidth != MediaQuery.of(context).size.width) {
      _calculateSize(context);
    }
  }

  double _realWidth;
  double _realHeight;
  double _mediaWidth;
  double _mediaHeight;
  double _maxWidth;
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

  final picker = ImagePicker();

  Future getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      io.File file = io.File(result.files.single.path);
      print(file.path);

      EasyLoading.show(status: 'Mengunggah data', dismissOnTap: true);

      if (_user.profilePicture != null) {
        await _user.updateData(authData: {UserModel.PROFILE_PICTURE: null});
        await deleteFile(url: _user.profilePicture);
      }

      String downloadUrl = await uploadFile(
          directory: 'users', uid: _user.uid, filePath: file.path, name: UserModel.PROFILE_PICTURE);
      _user.updateData(authData: {UserModel.PROFILE_PICTURE: downloadUrl});
      EasyLoading.dismiss();
      setState(() {
        print('PP-> ${_user.profilePicture}');
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        color: _sameRatio ? Colors.white : Colors.black12,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: _realHeight,
              maxWidth: _maxWidth,
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _realWidth * 0.05),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _realWidth * 0.1,
                      ),

                      // User Avatar
                      InkWell(
                        onTap: getImage,
                        child: _user.profilePicture != null
                            ? Container(
                                alignment: Alignment.center,
                                width: _realWidth * 0.4,
                                height: _realWidth * 0.4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black38,
                                  image: DecorationImage(
                                      image: NetworkImage(_user.profilePicture),
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                width: _realWidth * 0.4,
                                height: _realWidth * 0.4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera,
                                      size: _realWidth * 0.1,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      height: _realWidth * 0.04,
                                    ),
                                    // Skills Title
                                    Text(
                                      'Foto Profil (Ukuran 800x800)',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                      ),

                      SizedBox(
                        height: _realWidth * 0.1,
                      ),

                      // Skills Title
                      Container(
                          alignment: Alignment.centerLeft,
                          width: _maxWidth,
                          child: Text(
                            'Informasi Dasar',
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                        height: _realWidth * 0.05,
                      ),

                      // Name Data View
                      DataView(
                          leadingIcon: Icons.person,
                          trailingIcon: Icons.edit,
                          title: 'Nama',
                          value: _user.name,
                          realWidth: _realWidth,
                          maxWidth: _maxWidth,
                          onTap: _nameDialog),
                      SizedBox(
                        height: _realWidth * 0.05,
                      ),

                      // Phone Number Data View
                      DataView(
                          leadingIcon: Icons.phone,
                          trailingIcon: Icons.edit,
                          title: 'Nomor Telepon',
                          value: _user.phoneNumber != null
                              ? phoneNumberFormatter.maskText(_user.phoneNumber)
                              : '',
                          realWidth: _realWidth,
                          maxWidth: _maxWidth,
                          onTap: () =>
                              _textDialog(type: UserModel.PHONE_NUMBER)),
                      SizedBox(
                        height: _realWidth * 0.1,
                      ),

                      // Skills Title
                      Container(
                          alignment: Alignment.centerLeft,
                          width: _maxWidth,
                          child: Text(
                            'Keahlihan dan Pekerjaan',
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                        height: _realWidth * 0.05,
                      ),

                      // Skill 1 Data View
                      DataView(
                          leadingIcon: Icons.animation,
                          trailingIcon: Icons.edit,
                          title: 'Skill/Pekerjaan 1',
                          value: _jobValueGetter(0),
                          realWidth: _realWidth,
                          maxWidth: _maxWidth,
                          onTap: () => _dropdownDialog(
                              type: OptionModel.JOB, jobLevel: 0)),
                      SizedBox(
                        height: _realWidth * 0.05,
                      ),

                      // Skill 2 Data View
                      DataView(
                          leadingIcon: null,
                          trailingIcon: Icons.edit,
                          title: 'Skill/Pekerjaan 2',
                          value: _jobValueGetter(1),
                          realWidth: _realWidth,
                          maxWidth: _maxWidth,
                          onTap: () => _dropdownDialog(
                              type: OptionModel.JOB, jobLevel: 1)),
                      SizedBox(
                        height: _realWidth * 0.05,
                      ),

                      // Skill 2 Data View
                      DataView(
                          leadingIcon: null,
                          trailingIcon: Icons.edit,
                          title: 'Skill/Pekerjaan 3',
                          value: _jobValueGetter(2),
                          realWidth: _realWidth,
                          maxWidth: _maxWidth,
                          onTap: () => _dropdownDialog(
                              type: OptionModel.JOB, jobLevel: 2)),
                      SizedBox(
                        height: _realWidth * 0.05,
                      ),

                      // Address Title
                      Container(
                          alignment: Alignment.centerLeft,
                          width: _maxWidth,
                          child: Text(
                            'Informasi Alamat',
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                        height: _realWidth * 0.05,
                      ),

                      // Province Data View
                      DataView(
                          leadingIcon: Icons.streetview_rounded,
                          trailingIcon: Icons.edit,
                          title: 'Provinsi',
                          value: _user.currentAddress != null
                              ? (_user.currentAddress[OptionModel.PROVINCE] !=
                                      null
                                  ? _user.currentAddress[OptionModel.PROVINCE]
                                  : '')
                              : '',
                          realWidth: _realWidth,
                          maxWidth: _maxWidth,
                          onTap: () =>
                              _dropdownDialog(type: OptionModel.PROVINCE)),
                      SizedBox(
                        height: _realWidth * 0.05,
                      ),

                      // City Data View
                      DataView(
                          leadingIcon: null,
                          trailingIcon: Icons.edit,
                          title: 'Kota/Kabupaten',
                          value: _user.currentAddress != null
                              ? (_user.currentAddress[OptionModel.CITY] != null
                                  ? _user.currentAddress[OptionModel.CITY]
                                  : '')
                              : '',
                          realWidth: _realWidth,
                          maxWidth: _maxWidth,
                          onTap: () => _dropdownDialog(type: OptionModel.CITY)),
                      SizedBox(
                        height: _realWidth * 0.05,
                      ),

                      // District Data View
                      DataView(
                          leadingIcon: null,
                          trailingIcon: Icons.edit,
                          title: 'Kecamatan',
                          value: _user.currentAddress != null
                              ? (_user.currentAddress[OptionModel.DISTRICT] !=
                                      null
                                  ? _user.currentAddress[OptionModel.DISTRICT]
                                  : '')
                              : '',
                          realWidth: _realWidth,
                          maxWidth: _maxWidth,
                          onTap: () =>
                              _dropdownDialog(type: OptionModel.DISTRICT)),
                      SizedBox(
                        height: _realWidth * 0.05,
                      ),

                      // Street Data View
                      DataView(
                          leadingIcon: null,
                          trailingIcon: Icons.edit,
                          title: 'Jalan',
                          value: _user.currentAddress != null
                              ? (_user.currentAddress[OptionModel.STREET] != null
                                  ? _user.currentAddress[OptionModel.STREET]
                                  : '')
                              : '',
                          realWidth: _realWidth,
                          maxWidth: _maxWidth,
                          onTap: _streetDialog),
                      SizedBox(
                        height: _realWidth * 0.2,
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

  void _nameDialog() {
    String input = '';
    if (_user != null) {
      if (_user.name != UserModel.ERROR_MESSAGE) {
        input = _user.name;
      }
    }

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Masukan nama Anda',
                style: Theme.of(context).textTheme.headline6,
              ),
              content: TextField(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.bold),
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Masukan nama Anda disini',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  border: InputBorder.none,
                ),
                onChanged: (value) => input = value,
                controller: TextEditingController()..text = input,
              ),
              actions: [
                FlatButton(
                  child: Text(
                    'Batalkan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(
                  width: _realWidth * 0.1,
                ),
                FlatButton(
                  child: Text(
                    'Simpan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    EasyLoading.show(
                        status: 'Mengunggah data', dismissOnTap: true);

                    print('Set');
                    await FirebaseAuth.instance.currentUser
                        .updateProfile(displayName: input);
                    print('Ok 1');
                    setState(() {
                      print('new name ${_user.name}');
                    });
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                  },
                ),
              ],
            ));
  }

  void _textDialog({@required String type}) {
    String input = '';
    TextInputType inputType = TextInputType.name;

    String leadingInfo = 'Masukan';
    String mainInfo = 'nama';

    // String phoneNumber;
    // String codeNumber;
    // bool sendCode = false;

    switch (type) {
      case UserModel.PHONE_NUMBER:
        if (_user.phoneNumber != null) {
          input = _user.phoneNumber;
        }
        inputType = TextInputType.phone;
        mainInfo = 'Nomor telepon';
        break;
      case UserModel.NAME:
        if (_user != null) {
          if (_user.name != UserModel.ERROR_MESSAGE) {
            input = _user.name;
          }
        }
        break;
    }

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                '$leadingInfo $mainInfo Anda',
                style: Theme.of(context).textTheme.headline6,
              ),
              content:
                  // type == UserModel.PHONE_NUMBER
                  //   //   ?
                  //   Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         //Main Field
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             SizedBox(
                  //               width: _realWidth * 0.52,
                  //               height: _realHeight * 0.1,
                  //               child: TextField(
                  //                 keyboardType: inputType,
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .bodyText1
                  //                     .copyWith(fontWeight: FontWeight.bold),
                  //                 maxLines: 1,
                  //                 decoration: InputDecoration(
                  //                   hintText: '$leadingInfo $mainInfo Anda',
                  //                   hintStyle:
                  //                       Theme.of(context).textTheme.bodyText1,
                  //                 ),
                  //                 onChanged: (value) => input = value,
                  //                 controller: TextEditingController()
                  //                   ..text = input,
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: _realWidth * 0.05,
                  //             ),
                  //             InkWell(
                  //               child: Container(
                  //                 width: _realWidth * 0.1,
                  //                 height: _realWidth * 0.1,
                  //                 alignment: Alignment.center,
                  //
                  //                 child: Icon(
                  //                   Icons.send,
                  //                   size: _realWidth * 0.07,
                  //                   color: Theme.of(context).primaryColor,
                  //                 ),
                  //               ),
                  //               onTap: () {
                  //                 sendCode = true;
                  //               },
                  //             )
                  //           ],
                  //         ),
                  //         SizedBox(
                  //           height: _realWidth * 0.03,
                  //         ),
                  //
                  //         Text(
                  //           'Kode OTP',
                  //           style: Theme.of(context).textTheme.headline6,
                  //         ),
                  //         SizedBox(
                  //           height: _realWidth * 0.02,
                  //         ),
                  //         SizedBox(
                  //           width: _realWidth * 0.7,
                  //           height: _realHeight * 0.1,
                  //           child: TextField(
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText1
                  //                 .copyWith(fontWeight: FontWeight.bold),
                  //             maxLines: 1,
                  //             decoration: InputDecoration(
                  //               hintText: 'Masukkan kode OTP',
                  //               hintStyle:
                  //                   Theme.of(context).textTheme.bodyText1,
                  //             ),
                  //             keyboardType: TextInputType.number,
                  //             onChanged: (value) => codeNumber = value,
                  //             controller: TextEditingController()
                  //               ..text = codeNumber,
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  //   :
                  type == UserModel.PHONE_NUMBER
                      ? TextField(
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '$leadingInfo $mainInfo Anda',
                            hintStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                          onChanged: (value) => input = value,
                          controller: TextEditingController()..text = input,
                          inputFormatters: [phoneNumberFormatter],
                          keyboardType: inputType,
                        )
                      : TextField(
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '$leadingInfo $mainInfo Anda',
                            hintStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                          onChanged: (value) => input = value,
                          controller: TextEditingController()..text = input,
                        ),
              actions: [
                FlatButton(
                  child: Text(
                    'Batalkan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(
                  width: _realWidth * 0.1,
                ),
                FlatButton(
                  child: Text(
                    'Simpan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    EasyLoading.show(
                        status: 'Mengunggah data', dismissOnTap: true);

                    print('Set');

                    switch (type) {
                      case UserModel.PHONE_NUMBER:
                        await _user.updateData(firestoreData: {
                          UserModel.PHONE_NUMBER:
                              phoneNumberFormatter.getUnmaskedText()
                        });
                      // print('PA>> $phoneNumber');
                      // print('PA>> $sendCode');
                      // print('PA>> $codeNumber');
                      //
                      // if (sendCode) {
                      //   phoneNumber = input;
                      //   codeNumber = input;
                      //
                      //   print('===\nPA>> $phoneNumber');
                      //   print('PA>> $sendCode');
                      //   print('PA>> $codeNumber');
                      //
                      //   FirebaseAuth.instance.verifyPhoneNumber(
                      //       phoneNumber: '+'+ phoneNumber,
                      //       timeout: Duration(seconds: 60),
                      //       verificationCompleted:
                      //           (AuthCredential credential) async {
                      //         Navigator.of(context).pop();
                      //         await (FirebaseAuth.instance.currentUser)
                      //             .updatePhoneNumber(credential);
                      //
                      //         //This callback would gets called when verification is done auto maticlly
                      //       },
                      //       verificationFailed: (error) {
                      //         // TODO : ERROR
                      //       },
                      //       codeSent: (String verificationId,
                      //           [int forceResendingToken]) async {
                      //         final AuthCredential credential =
                      //             PhoneAuthProvider.credential(
                      //                 verificationId: verificationId,
                      //                 smsCode: codeNumber);
                      //         await (FirebaseAuth.instance.currentUser)
                      //             .updatePhoneNumber(credential);
                      //         Navigator.of(context).pop();
                      //       },
                      //       codeAutoRetrievalTimeout: (String verificationId){});
                      //
                      //   Navigator.pop(context);
                      // }
                    }

                    setState(() {});
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                  },
                ),
              ],
            ));
  }

  void _streetDialog() {
    Map<String, String> address = {
      OptionModel.PROVINCE: null,
      OptionModel.CITY: null,
      OptionModel.DISTRICT: null,
      OptionModel.STREET: null,
    };
    String input = '';
    if (_user != null) {
      if (_user.currentAddress != null) {
        address = _user.currentAddress;
        if (_user.currentAddress[OptionModel.STREET] != null) {
          input = _user.currentAddress[OptionModel.STREET];
        }
      }
    }

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Masukan jalan Anda',
                style: Theme.of(context).textTheme.headline6,
              ),
              content: TextField(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.bold),
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Masukan alamat Anda disini',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  border: InputBorder.none,
                ),
                onChanged: (value) => input = value,
                controller: TextEditingController()..text = input,
              ),
              actions: [
                FlatButton(
                  child: Text(
                    'Batalkan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(
                  width: _realWidth * 0.1,
                ),
                FlatButton(
                  child: Text(
                    'Simpan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    EasyLoading.show(
                        status: 'Mengunggah data', dismissOnTap: true);

                    print('Set');
                    address[OptionModel.STREET] = input;
                    await _user.updateData(
                        firestoreData: {UserModel.CURRENT_ADDRESS: address});
                    print('Ok 1');
                    setState(() {
                      _user.update(UserModel.CURRENT_ADDRESS);
                    });
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                  },
                ),
              ],
            ));
  }

  void _dropdownDialog({@required String type, int jobLevel = 0}) {
    String placeParameter;
    String leadingString;
    List<DropdownMenuItem<dynamic>> items;

    List<String> jobs = ["", "", ""];

    Map<String, String> address = {
      OptionModel.PROVINCE: null,
      OptionModel.CITY: null,
      OptionModel.DISTRICT: null,
      OptionModel.STREET: null,
    };
    String input = '';

    if (type != OptionModel.JOB) {
      if (_user != null) {
        if (_user.currentAddress != null) {
          address = _user.currentAddress;
          if (_user.currentAddress[type] != null) {
            input = _user.currentAddress[type];
          }
        }
      }

      leadingString = 'Ubah Alamat';

      switch (type) {
        case OptionModel.STREET:
          placeParameter = 'Desa/Dusun';
          break;
        case OptionModel.DISTRICT:
          items = _placeModel.districtList;
          placeParameter = 'Kecamatan';
          break;
        case OptionModel.CITY:
          items = _placeModel.cityList;
          placeParameter = 'Kota/Kabupaten';
          break;
        case OptionModel.PROVINCE:
          items = _placeModel.provinceList;
          placeParameter = 'Provinsi';
          break;
      }
    } else {
      if (_user != null) {
        if (_user.job != null) {
          if (_user.job.length == 3) {
            jobs = _user.job;
          }
        }

        input = _jobValueGetter(jobLevel);
      } else {
        // TODO: ERROR USER

      }

      leadingString = 'Pilih';
      placeParameter = 'Keahlihan';

      items = _placeModel.jobList;
      // List<String> itemRemover = jobs;
      // itemRemover.removeAt(jobLevel);

      // print('JL => ${jobs.length}');
      //
      // jobs.forEach((element) {
      //   print('JB=>\t $element');
      //
      // });
      //
      // if (_user.job != null ) {
      //   _user.job.forEach((element) {
      //     print('US=>\t $element');
      //   });
      // }

      // itemRemover.forEach((element) {
      //   print('IR=>\t $element');
      // });

      items.removeWhere((element) {
        if (jobs.contains(element.value) && element.value != jobs[jobLevel]) {
          return true;
        }
        return false;
      });
    }

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                '$leadingString $placeParameter Anda',
                style: Theme.of(context).textTheme.headline6,
              ),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: _realHeight * 0.15,
                ),
                child: SearchableDropdown.single(
                  items: items,
                  value: input,
                  hint: "Pilih $placeParameter",
                  searchHint: "Pilih $placeParameter",
                  onChanged: (value) {
                    input = value;
                  },
                  isExpanded: true,
                  isCaseSensitiveSearch: false,
                ),
              ),
              actions: [
                FlatButton(
                  child: Text(
                    'Batalkan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(
                  width: _realWidth * 0.1,
                ),
                FlatButton(
                  child: Text(
                    'Simpan',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    EasyLoading.show(
                        status: 'Mengunggah data', dismissOnTap: true);

                    print('Set');

                    if (type != OptionModel.JOB) {
                      address[type] = input;
                      await _user.updateData(
                          firestoreData: {UserModel.CURRENT_ADDRESS: address});
                    } else {
                      jobs[jobLevel] = input;
                      await _user
                          .updateData(firestoreData: {UserModel.JOB: jobs});
                    }

                    print('Ok 1');
                    setState(() {});
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                  },
                ),
              ],
            ));
  }
}

