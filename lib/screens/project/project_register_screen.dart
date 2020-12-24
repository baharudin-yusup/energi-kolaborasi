import 'package:energi_kolaborasi/models/place_model.dart';
import 'package:energi_kolaborasi/models/project_model.dart';
import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:energi_kolaborasi/utils/function.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:energi_kolaborasi/utils/space.dart';
import 'package:energi_kolaborasi/widgets/file_card.dart';
import 'package:energi_kolaborasi/widgets/abstract_button.dart';
import 'package:energi_kolaborasi/widgets/dropdown_picker.dart';
import 'package:energi_kolaborasi/widgets/header_image.dart';
import 'package:energi_kolaborasi/widgets/string_input.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mime/mime.dart';

import 'package:energi_kolaborasi/services/store_data.dart';

import 'package:flutter/services.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

enum ProjectType {
  research,
  consultant,
  investor,
  startup
}

class ProjectRegisterScreen extends StatefulWidget {
  final ProjectType type;

  ProjectRegisterScreen({this.type = ProjectType.research});

  @override
  _ProjectRegisterScreenState createState() => _ProjectRegisterScreenState();
}

class _ProjectRegisterScreenState extends State<ProjectRegisterScreen> {

  String _title;

  // Research File
  PlatformFile _abstractForm;
  PlatformFile _designForm;
  PlatformFile _financeForm;

  // Consultant File
  PlatformFile _consultantId;
  String _consultantCompanyName;

  // Investor File
  PlatformFile _investorId;
  String _investorUserType;
  String _investorCompanyName;

  // Startup File
  PlatformFile _proposalForm;
  PlatformFile _pitchDeckForm;

  OptionModel _optionModel;
  var phoneNumberFormatter = MaskTextInputFormatter(
      mask: '+## ###-####-####', filter: {"#": RegExp(r'[0-9]')});
  final _formKey = GlobalKey<FormState>();

  String _nameField;
  String _instituteField;
  String _categoryField;
  String _emailField;
  String _phoneNumberField;

  double _realWidth;
  double _realHeight;
  double _mediaWidth;
  double _mediaHeight;
  Space _height;
  bool _perfectRatio = true;


  @override
  void initState() {

    _optionModel = OptionModel.instance;
    _initializeData();

    super.initState();
  }

  void _initializeData() {

    String tempTitle;

    switch(widget.type) {
      case ProjectType.research :
        tempTitle = 'Buat Proyek Riset';
        break;
      case ProjectType.consultant:
        tempTitle = 'Mendaftar Sebagai Konsultan';
        break;
      case ProjectType.investor :
        tempTitle = 'Mendaftar Sebagai Pendana';
        break;
      case ProjectType.startup :
        tempTitle = 'Buat Suatu Startup';
        break;
    }


    setState(() {
      _title = tempTitle;
    });

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
                title: Text(_title),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _realWidth * 0.05),
                  child: _content(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    switch(widget.type) {
      case ProjectType.research :
        return _researchForm();
      case ProjectType.consultant:
        return _consultantForm();
      case ProjectType.investor:
        return _investorForm();
      case ProjectType.startup:
        return _startupForm();
      default:
        return _researchForm();
    }
  }

  Widget _researchForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Header
          SizedBox(height: _height.height4,),
          HeaderImage(
            title: 'Buat dan Daftarkan Risetmu Sekarang!',
            size: _realWidth,
            image: AssetImage('assets/images/collaboration.jpg'),
            subtitle: 'Jangan lupa isi semua datanya',
          ),
          SizedBox(height: _height.height3,),

          // Research Information
          Text(
            'Informasi Riset',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: _height.height5,
          ),
          Text(
            'Mohon lengkapi data-data berikut untuk mengajukan diri sebagai pengaju',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: _height.height4,
          ),

          // Title Form
          Text(
            'Judul Riset',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          StringInput(size: _realWidth, hint: 'Judul Riset', onChanged: (value) => _nameField = value),
          SizedBox(
            height: _height.height4,
          ),

          // Institute Form
          Text(
            'Asal Institusi',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          StringInput(size: _realWidth, hint: 'Asal Institusi', onChanged: (value) => _instituteField = value),
          SizedBox(
            height: _height.height4,
          ),

          // Category Form
          Text(
            'Bidang Riset',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          DropdownPicker.single(onChanged: (value) => _categoryField = value, size: _realWidth, items: _optionModel.categoryList, hint: 'Bidang Riset'),
          SizedBox(
            height: _height.height4,
          ),

          // Email Form
          Text(
            'E-Mail',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          StringInput(size: _realWidth, hint: 'E-Mail', onChanged: (value) => _emailField = value, keyboardType: TextInputType.emailAddress,),
          SizedBox(
            height: _height.height4,
          ),

          // Phone Form
          Text(
            'Nomor Handphone',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          StringInput(inputFormatters: [phoneNumberFormatter], size: _realWidth, hint: 'Nomor Handphone', onChanged: (value) => _phoneNumberField = value, keyboardType: TextInputType.phone,),
          SizedBox(
            height: _height.height3,
          ),

          // File Information
          Text(
            'Berkas',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: _height.height5,
          ),
          Text(
            'Mohon lengkapi data-data berikut untuk mengajukan diri sebagai konsultan',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: _height.height3,
          ),

          // Abstract Form
          Text(
            'Abstrak Penelitian',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          FileCard(
            size: _realWidth,
            title: _abstractForm?.name,
            onTap: () async {
              PlatformFile file = await selectFile();

              if (_abstractForm != file) {
                setState(() {
                  _abstractForm = file;
                });
              }
            },
          ),
          SizedBox(
            height: _height.height3,
          ),

          // Design Form
          Text(
            'Desain Teknik',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          FileCard(
            size: _realWidth,
            title: _designForm?.name,
            onTap: () async {
              PlatformFile file = await selectFile();

              if (_designForm != file) {
                setState(() {
                  _designForm = file;
                });
              }
            },
          ),
          SizedBox(
            height: _height.height4,
          ),


          // RAB Form
          Text(
            'RAB Riset',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          FileCard(
            size: _realWidth,
            title: _financeForm?.name,
            onTap: () async {
              PlatformFile file = await selectFile();

              if (_financeForm != file) {
                setState(() {
                  _financeForm = file;
                });
              }
            },
          ),
          SizedBox(
            height: _height.height3,
          ),

          AbstractButton(size: _realWidth, title: 'Submit', onTap: _submitButton),
          SizedBox(
            height: _height.height3,
          ),
        ],
      ),
    );
  }


  String _consultantUserType;

  Widget _consultantForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Header
          SizedBox(height: _height.height4,),
          HeaderImage(
            title: 'Ajukan Dirimu atau Perusahaanmu Menjadi Konsultan',
            size: _realWidth,
            image: AssetImage('assets/images/collaboration.jpg'),
            subtitle: 'Jangan lupa isi semua datanya',
          ),
          SizedBox(height: _height.height3,),


          // User Type Form
          Text(
            'Bidang Riset',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          DropdownPicker.single(onChanged: (value) => _consultantUserType = value, size: _realWidth, items: _optionModel.userTypeList, hint: 'Jenis Akun'),
          (_consultantUserType ?? false) == OptionModel.USER_TYPE_LIST[1] ? SizedBox(
            height: _height.height4,
          ) : SizedBox(
            height: _height.height3,
          ),

          // Name Form
          (_consultantUserType ?? false) == OptionModel.USER_TYPE_LIST[1] ? Text(
            'Judul Riset',
            style: Theme.of(context).textTheme.headline6,
          ) :  SizedBox(),
          (_consultantUserType ?? false) == OptionModel.USER_TYPE_LIST[1] ? SizedBox(
            height: _height.height5,
          ) : SizedBox(),
          (_consultantUserType ?? false) == OptionModel.USER_TYPE_LIST[1] ? StringInput(size: _realWidth, hint: 'Nama Perusahaan/Institusi', onChanged: (value) => _nameField = value) : SizedBox(),
          (_consultantUserType ?? false) == OptionModel.USER_TYPE_LIST[1] ? SizedBox(
            height: _height.height3,
          ) : SizedBox(),

          // File Information
          Text(
            'Berkas',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: _height.height5,
          ),
          Text(
            'Mohon lengkapi data-data berikut untuk mengajukan diri sebagai konsultan',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: _height.height3,
          ),

          // Institution ID Form
          Text(
            'Kartu Tanda Pengenal Konsultan',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          FileCard(
            size: _realWidth,
            title: _consultantId?.name,
            onTap: () async {
              PlatformFile file = await selectFile();

              if (_consultantId != file) {
                setState(() {
                  _consultantId = file;
                });
              }
            },
          ),
          SizedBox(
            height: _height.height3,
          ),

          AbstractButton(size: _realWidth, title: 'Submit', onTap: _submitButton),
          SizedBox(
            height: _height.height3,
          ),
        ],
      ),
    );
  }

  Widget _investorForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Header
          SizedBox(height: _height.height4,),
          HeaderImage(
            title: 'Ajukan Dirimu atau Perusahaanmu Menjadi Konsultan',
            size: _realWidth,
            image: AssetImage('assets/images/collaboration.jpg'),
            subtitle: 'Jangan lupa isi semua datanya',
          ),
          SizedBox(height: _height.height3,),


          // User Type Form
          Text(
            'Bidang Riset',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          DropdownPicker.single(onChanged: (value) => _investorUserType = value, size: _realWidth, items: _optionModel.userTypeList, hint: 'Jenis Akun'),
          (_investorUserType ?? false) == OptionModel.USER_TYPE_LIST[1] ? SizedBox(
            height: _height.height4,
          ) : SizedBox(
            height: _height.height3,
          ),

          // Name Form
          (_investorUserType ?? false) == OptionModel.USER_TYPE_LIST[1] ? Text(
            'Nama Perusahaan/Institusi',
            style: Theme.of(context).textTheme.headline6,
          ) :  SizedBox(),
          (_investorUserType ?? false) == OptionModel.USER_TYPE_LIST[1] ? SizedBox(
            height: _height.height5,
          ) : SizedBox(),
          (_investorUserType ?? false) == OptionModel.USER_TYPE_LIST[1] ? StringInput(size: _realWidth, hint: 'Nama Perusahaan/Institusi', onChanged: (value) => _consultantCompanyName = value) : SizedBox(),
          (_investorUserType ?? false) == OptionModel.USER_TYPE_LIST[1] ? SizedBox(
            height: _height.height3,
          ) : SizedBox(),

          // File Information
          Text(
            'Berkas',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: _height.height5,
          ),
          Text(
            'Mohon lengkapi data-data berikut untuk mengajukan diri sebagai konsultan',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: _height.height3,
          ),

          // Institution ID Form
          Text(
            'Kartu Tanda Pengenal Investor',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          FileCard(
            size: _realWidth,
            title: _investorId?.name,
            onTap: () async {
              PlatformFile file = await selectFile();

              if (_investorId != file) {
                setState(() {
                  _investorId = file;
                });
              }
            },
          ),
          SizedBox(
            height: _height.height3,
          ),

          AbstractButton(size: _realWidth, title: 'Submit', onTap: _submitButton),
          SizedBox(
            height: _height.height3,
          ),
        ],
      ),
    );
  }

  Widget _startupForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Header
          SizedBox(height: _height.height4,),
          HeaderImage(
            title: 'Buat dan Daftarkan Startupmu Sekarang!',
            size: _realWidth,
            image: AssetImage('assets/images/collaboration.jpg'),
            subtitle: 'Jangan lupa isi semua datanya',
          ),
          SizedBox(height: _height.height3,),

          // Startup Information
          Text(
            'Informasi Startup',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: _height.height5,
          ),
          Text(
            'Mohon lengkapi data-data berikut untuk mengajukan diri sebagai pengaju',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: _height.height4,
          ),

          // Title Form
          Text(
            'Nama Startup',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          StringInput(size: _realWidth, hint: 'Nama Startup', onChanged: (value) => _nameField = value),
          SizedBox(
            height: _height.height4,
          ),

          // Institute Form
          Text(
            'Asal Institusi',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          StringInput(size: _realWidth, hint: 'Asal Institusi', onChanged: (value) => _instituteField = value),
          SizedBox(
            height: _height.height4,
          ),

          // Category Form
          Text(
            'Bidang Startup',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          DropdownPicker.single(onChanged: (value) => _categoryField = value, size: _realWidth, items: _optionModel.categoryList, hint: 'Bidang Startup'),
          SizedBox(
            height: _height.height4,
          ),

          // Email Form
          Text(
            'E-Mail Startup',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          StringInput(size: _realWidth, hint: 'E-Mail Startup', onChanged: (value) => _emailField = value, keyboardType: TextInputType.emailAddress,),
          SizedBox(
            height: _height.height4,
          ),

          // Phone Form
          Text(
            'Nomor Handphone',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          StringInput(inputFormatters: [phoneNumberFormatter], size: _realWidth, hint: 'Nomor Handphone', onChanged: (value) => _phoneNumberField = value, keyboardType: TextInputType.phone,),
          SizedBox(
            height: _height.height3,
          ),

          // Headline 5
          Text(
            'Berkas',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: _height.height5,
          ),
          Text(
            'Mohon lengkapi data-data berikut untuk mengajukan diri sebagai konsultan',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: _height.height3,
          ),

          // Abstract Form
          Text(
            'Proposal Startup',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          FileCard(
            size: _realWidth,
            title: _proposalForm?.name,
            onTap: () async {
              PlatformFile file = await selectFile();

              if (_proposalForm != file) {
                setState(() {
                  _proposalForm = file;
                });
              }
            },
          ),
          SizedBox(
            height: _height.height3,
          ),

          // Design Form
          Text(
            'Pitch Deck',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: _height.height5,
          ),
          FileCard(
            size: _realWidth,
            title: _pitchDeckForm?.name,
            onTap: () async {
              PlatformFile file = await selectFile();

              if (_pitchDeckForm != file) {
                setState(() {
                  _pitchDeckForm = file;
                });
              }
            },
          ),
          SizedBox(
            height: _height.height3,
          ),

          AbstractButton(size: _realWidth, title: 'Submit', onTap: _submitButton),
          SizedBox(
            height: _height.height3,
          ),
        ],
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


  Future<PlatformFile> selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);

      return file;
    } else {
      // User canceled the picker
      return null;
    }
  }

  bool isDocument(String path) {
    final mimeType = lookupMimeType(path);
    return mimeType == 'application/pdf';
  }

  List<String> _isError() {
    List<String> error = [];

    switch (widget.type) {
      case ProjectType.research :
        // Name Validator
        if (_nameField == null || _nameField?.trim() == '') {
          error.add('Judul riset tidak boleh kosong');
        }

        // Name Validator
        if (_instituteField == null || _instituteField?.trim() == '') {
          error.add('Asal institusi tidak boleh kosong');
        }

        // Category Validator
        if (_categoryField == null || _categoryField?.trim() == '') {
          error.add('Bidang kategori tidak boleh kosong');
        }

        // Email Validator
        if (_emailField == null ||
            _emailField?.trim() == '' ||
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(_emailField ?? '')) {
          error.add('Email tidak boleh kosong');
        }

        // Phone Number Validator
        if (_phoneNumberField == null || _phoneNumberField?.trim() == '') {
          error.add('Nomor telepon tidak boleh kosong');
        }

        // Abstract Validator
        if (_abstractForm == null) {
          error.add('Berkas abstrak tidak boleh kosong');
        }

        // Design Validator
        if (_designForm == null) {
          error.add('Berkas desain tidak boleh kosong');
        }

        // Finance Validator
        if (_financeForm == null) {
          error.add('Berkas RAB tidak boleh kosong');
        }
        break;
      case ProjectType.consultant:
        // Consultant Type
        if (_consultantUserType == null) {
          error.add('Tipe Konsultan tidak boleh kosong');
        }
        // Consultant Name for Company
        if (((_consultantUserType ?? false) == OptionModel.USER_TYPE_LIST[1]) && _consultantCompanyName == null) {
          error.add('Nama Perusahaan/Institusi tidak boleh kosong');
        }
        // Consultant ID
        if (_consultantId == null) {
          error.add('Berkas pengenal Konsultan tidak boleh jo ');
        }

        break;
      case ProjectType.investor:
      // Consultant Type
        if (_consultantUserType == null) {
          error.add('Tipe Investor tidak boleh kosong');
        }
        // Consultant Name for Company
        if (((_consultantUserType ?? false) == OptionModel.USER_TYPE_LIST[1]) && _consultantCompanyName == null) {
          error.add('Nama Perusahaan/Institusi tidak boleh kosong');
        }
        // Consultant ID
        if (_consultantId == null) {
          error.add('Berkas pengenal Investor tidak boleh kosong');
        }

        break;
      case ProjectType.startup:
      // Name Validator
        if (_nameField == null || _nameField?.trim() == '') {
          error.add('Nama startup tidak boleh kosong');
        }

        // Name Validator
        if (_instituteField == null || _instituteField?.trim() == '') {
          error.add('Asal institusi tidak boleh kosong');
        }

        // Category Validator
        if (_categoryField == null || _categoryField?.trim() == '') {
          error.add('Bidang kategori tidak boleh kosong');
        }

        // Email Validator
        if (_emailField == null ||
            _emailField?.trim() == '' ||
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(_emailField ?? '')) {
          error.add('Email tidak boleh kosong');
        }

        // Phone Number Validator
        if (_phoneNumberField == null || _phoneNumberField?.trim() == '') {
          error.add('Nomor telepon tidak boleh kosong');
        }

        // Proposal Validator
        if (_proposalForm == null) {
          error.add('Berkas propsal tidak boleh kosong');
        }

        // Pitch Deck Validator
        if (_pitchDeckForm == null) {
          error.add('Berkas pitch deck tidak boleh kosong');
        }

        break;
    }

    return error;

  }

  Future<void> _submitButton() async {
    List<String> error = _isError();

    if (error.length > 0) {
      await EasyLoading.showError('Ada ${error.length} data yang belum diisi atau salah',
          duration: Duration(milliseconds: 1000), dismissOnTap: true);

      return;
    }

    EasyLoading.showProgress(0.0, status: 'Mengunggah data');

    switch (widget.type) {
      case ProjectType.research:
        Map<String, dynamic> data = {
          'uploader': UserModel.instance.uid,
          'title': _nameField,
          'institution': _instituteField,
          'category': _categoryField,
          'email': _emailField,
          'phone_number': _phoneNumberField,
          'level': 0,
        };

        String id = await createFirestore(
          collectionPath: 'research',
          data: data,
        );

        String abstractURL = await uploadFile(
            directory: 'research',
            uid: id,
            filePath: _abstractForm.path,
            name: _abstractForm.name);
        EasyLoading.showProgress(0.5, status: 'Mengunggah data');
        await updateFirestore(collectionPath: 'research', uid: id, data: {
          ProjectModel.ABSTRACT_URL: {
            ProjectModel.FILE_NAME: _abstractForm.name,
            ProjectModel.FILE_URL: abstractURL,
          }
        });
        EasyLoading.showProgress(0.6, status: 'Mengunggah data');

        String financeURL = await uploadFile(
            directory: 'research',
            uid: id,
            filePath: _financeForm.path,
            name: _financeForm.name);
        EasyLoading.showProgress(0.7, status: 'Mengunggah data');
        await updateFirestore(collectionPath: 'research', uid: id, data: {
          ProjectModel.FINANCE_URL: {
            ProjectModel.FILE_NAME: _financeForm.name,
            ProjectModel.FILE_URL: financeURL,
          }
        });
        EasyLoading.showProgress(0.8, status: 'Mengunggah data');

        String designURL = await uploadFile(
            directory: 'research',
            uid: id,
            filePath: _designForm.path,
            name: _designForm.name);
        EasyLoading.showProgress(0.9, status: 'Mengunggah data');
        await updateFirestore(collectionPath: 'research', uid: id, data: {
          ProjectModel.DESIGN_URL: {
            ProjectModel.FILE_NAME: _designForm.name,
            ProjectModel.FILE_URL: designURL,
          }
        });
        EasyLoading.showProgress(1.0, status: 'Mengunggah data');

        EasyLoading.dismiss();

        Navigator.pushReplacementNamed(context, RouteHandler.RESEARCH_LIST,);

        break;
      case ProjectType.startup:
        Map<String, dynamic> data = {
          'uploader': UserModel.instance.uid,
          'title': _nameField,
          'institution': _instituteField,
          'category': _categoryField,
          'email': _emailField,
          'phone_number': _phoneNumberField,
          'level': 0,
        };

        EasyLoading.showProgress(0.4, status: 'Mengunggah data');

        String id = await createFirestore(
          collectionPath: 'startup',
          data: data,
        );

        String proposalURL = await uploadFile(
            directory: 'startup',
            uid: id,
            filePath: _proposalForm.path,
            name: _proposalForm.name);
        EasyLoading.showProgress(0.5, status: 'Mengunggah berkas proposal');
        await updateFirestore(collectionPath: 'startup', uid: id, data: {
          ProjectModel.PROPOSAL_URL: {
            ProjectModel.FILE_NAME: _proposalForm.name,
            ProjectModel.FILE_URL: proposalURL,
          }
        });
        EasyLoading.showProgress(0.6, status: 'Mengunggah berkas proposal');

        String pitchDeckURL = await uploadFile(
            directory: 'startup',
            uid: id,
            filePath: _pitchDeckForm.path,
            name: _pitchDeckForm.name);
        EasyLoading.showProgress(0.7, status: 'Mengunggah berkas pitch deck');
        await updateFirestore(collectionPath: 'startup', uid: id, data: {
          ProjectModel.PITCH_DECK_URL: {
            ProjectModel.FILE_NAME: _pitchDeckForm.name,
            ProjectModel.FILE_URL: pitchDeckURL,
          }
        });
        EasyLoading.showProgress(1.0, status: 'Mengunggah berkas pitch deck');

        EasyLoading.dismiss();

        Navigator.pushReplacementNamed(context, RouteHandler.STARTUP_LIST);

        break;
    }

  }





  // void _calculateSize(BuildContext context) {
  //   if (kIsWeb) {
  //     print(_sameRatio ? 'YA' : 'NO');
  //
  //     // TODO: Resolution 16:9
  //
  //     // Portrait\
  //
  //     if (_mediaHeight != MediaQuery.of(context).size.height ||
  //         _mediaWidth != MediaQuery.of(context).size.width) {
  //       _mediaHeight = MediaQuery.of(context).size.height;
  //       _mediaWidth = MediaQuery.of(context).size.width;
  //
  //       double tempHeight = MediaQuery.of(context).size.height;
  //       double tempWidth = tempHeight * (9 / 16);
  //       bool ratioChange;
  //
  //       print((MediaQuery.of(context).size.width - tempWidth).abs());
  //       print('W=> $tempWidth \t ${tempWidth * 0.1}');
  //       if ((MediaQuery.of(context).size.width - tempWidth).abs() <=
  //           tempWidth * 0.1) {
  //         ratioChange = true;
  //       } else {
  //         ratioChange = false;
  //       }
  //
  //       setState(() {
  //         _realHeight = tempHeight;
  //         _realWidth = tempWidth;
  //         _sameRatio = ratioChange;
  //         _maxWidth = _realWidth;
  //       });
  //     }
  //   } else {
  //     if (_mediaHeight != MediaQuery.of(context).size.height ||
  //         _mediaWidth != MediaQuery.of(context).size.width) {
  //       _mediaHeight = MediaQuery.of(context).size.height;
  //       _mediaWidth = MediaQuery.of(context).size.width;
  //
  //       setState(() {
  //         _realWidth = _mediaWidth;
  //         _realHeight = _mediaHeight;
  //         _maxWidth = _realWidth;
  //       });
  //     }
  //   }
  // }



  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         widget.isStartup ? 'Mulai Proyek Startup' : 'Mulai Proyek Riset',
  //         style: Theme.of(context).textTheme.headline6,
  //       ),
  //       centerTitle: true,
  //     ),
  //     body: SingleChildScrollView(
  //       padding: EdgeInsets.only(
  //           left: _realWidth * 0.05,
  //           right: _realWidth * 0.05,
  //           top: _realWidth * 0.1),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //             // Headline 5
  //             Text(
  //               'Informasi Proyek',
  //               style: Theme.of(context).textTheme.headline4,
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //             Text(
  //               'Mohon lengkapi data-data berikut untuk mengajukan diri sebagai pengaju',
  //               style: Theme.of(context).textTheme.subtitle1,
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.08,
  //             ),
  //
  //             // Name Form
  //             Text(
  //               widget.isStartup ? 'Judul Startup' : 'Judul Riset',
  //               style: Theme.of(context).textTheme.bodyText1,
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //             _nameFormField(),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //
  //             // Institute Form
  //             Text(
  //               'Asal Institusi',
  //               style: Theme.of(context).textTheme.bodyText1,
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //             _instituteFormField(),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //
  //             // Category Form
  //             Text(
  //               widget.isStartup ? 'Bidang Startup' : 'Bidang Riset',
  //               style: Theme.of(context).textTheme.bodyText1,
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //             _categoryFormField(),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //
  //             // Email Form
  //             Text(
  //               'E-mail',
  //               style: Theme.of(context).textTheme.bodyText1,
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //             _emailFormField(),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //
  //             // Phone Form
  //             Text(
  //               'No. Handphone',
  //               style: Theme.of(context).textTheme.bodyText1,
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //             _phoneNumberFormField(),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //             // Headline 5
  //             Text(
  //               'Berkas',
  //               style: Theme.of(context).textTheme.headline4,
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.03,
  //             ),
  //             Text(
  //               'Mohon lengkapi data-data berikut untuk mengajukan diri sebagai konsultan',
  //               style: Theme.of(context).textTheme.subtitle1,
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.08,
  //             ),
  //
  //             fileChoice(),
  //
  //             SizedBox(
  //               height: _realWidth * 0.11,
  //             ),
  //
  //             RaisedButton(
  //               color: Colors.transparent,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20.0),
  //               ),
  //               elevation: 0.0,
  //               padding: EdgeInsets.all(0.0),
  //               onPressed: _submitButton,
  //               child: AbstractButton(
  //                 size: _maxWidth,
  //                 title: 'Submit',
  //               ),
  //             ),
  //             SizedBox(
  //               height: _realWidth * 0.2,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget fileChoice() {
  //
  //   switch()
  //
  //   if (widget.isStartup) {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Abstract Form
  //         Text(
  //           'Proposal Startup',
  //           style: Theme.of(context).textTheme.headline6,
  //         ),
  //         SizedBox(
  //           height: _realWidth * 0.03,
  //         ),
  //         FileCard(
  //           size: _maxWidth,
  //           title: _proposalForm?.name,
  //           onTap: () async {
  //             PlatformFile file = await selectFile();
  //
  //             if (_proposalForm != file) {
  //               setState(() {
  //                 _proposalForm = file;
  //               });
  //             }
  //           },
  //         ),
  //         SizedBox(
  //           height: _realWidth * 0.06,
  //         ),
  //
  //         // Pitch Deck Form
  //         Text(
  //           'Pitch Deck',
  //           style: Theme.of(context).textTheme.headline6,
  //         ),
  //         SizedBox(
  //           height: _realWidth * 0.03,
  //         ),
  //         FileCard(
  //           size: _maxWidth,
  //           title: _pitchDeckForm?.name,
  //           onTap: () async {
  //             PlatformFile file = await selectFile();
  //
  //             if (_pitchDeckForm != file) {
  //               setState(() {
  //                 _pitchDeckForm = file;
  //               });
  //             }
  //           },
  //         ),
  //         SizedBox(
  //           height: _realWidth * 0.06,
  //         ),
  //       ],
  //     );
  //   } else {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Abstract Form
  //         Text(
  //           'Abstrak Penelitian',
  //           style: Theme.of(context).textTheme.headline6,
  //         ),
  //         SizedBox(
  //           height: _realWidth * 0.03,
  //         ),
  //         FileCard(
  //           size: _maxWidth,
  //           title: _abstractForm?.name,
  //           onTap: () async {
  //             PlatformFile file = await selectFile();
  //
  //             if (_abstractForm != file) {
  //               setState(() {
  //                 _abstractForm = file;
  //               });
  //             }
  //           },
  //         ),
  //         SizedBox(
  //           height: _realWidth * 0.06,
  //         ),
  //
  //         // Design Form
  //         Text(
  //           'Desain Teknik',
  //           style: Theme.of(context).textTheme.headline6,
  //         ),
  //         SizedBox(
  //           height: _realWidth * 0.03,
  //         ),
  //         FileCard(
  //           size: _maxWidth,
  //           title: _designForm?.name,
  //           onTap: () async {
  //             PlatformFile file = await selectFile();
  //
  //             if (_designForm != file) {
  //               setState(() {
  //                 _designForm = file;
  //               });
  //             }
  //           },
  //         ),
  //         SizedBox(
  //           height: _realWidth * 0.06,
  //         ),
  //
  //         // RAB Form
  //         Text(
  //           'RAB Riset',
  //           style: Theme.of(context).textTheme.headline6,
  //         ),
  //         SizedBox(
  //           height: _realWidth * 0.03,
  //         ),
  //         FileCard(
  //           size: _maxWidth,
  //           title: _financeForm?.name,
  //           onTap: () async {
  //             PlatformFile file = await selectFile();
  //
  //             if (_financeForm != file) {
  //               setState(() {
  //                 _financeForm = file;
  //               });
  //             }
  //           },
  //         ),
  //         SizedBox(
  //           height: _realWidth * 0.06,
  //         ),
  //       ],
  //     );
  //   }
  // }



  // Widget _instituteFormField() {
  //   return Container(
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(15.0),
  //       ),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           blurRadius: 0.5,
  //           spreadRadius: 2.0,
  //           offset: Offset(0.0, 0.0), // shadow direction: bottom right
  //         )
  //       ],
  //     ),
  //     width: _maxWidth,
  //     height: _maxWidth / 6,
  //     child: Padding(
  //       padding: const EdgeInsets.all(11.0),
  //       child: TextFormField(
  //         decoration: InputDecoration(
  //           hintStyle: Theme.of(context).textTheme.bodyText2,
  //           hintText: 'Institusi',
  //           border: InputBorder.none,
  //         ),
  //         maxLines: 1,
  //         controller: TextEditingController()..text = _instituteField,
  //         onChanged: (value) => _instituteField = value,
  //         onSaved: (newValue) => _instituteField = newValue,
  //         textAlign: TextAlign.start,
  //         style: Theme.of(context).textTheme.bodyText1,
  //         autocorrect: false,
  //       ),
  //     ),
  //   );
  // }



  // Widget _categoryFormField() {
  //   return Container(
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(15.0),
  //       ),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           blurRadius: 0.5,
  //           spreadRadius: 2.0,
  //           offset: Offset(0.0, 0.0), // shadow direction: bottom right
  //         )
  //       ],
  //     ),
  //     width: _maxWidth,
  //     height: _maxWidth / 4,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 4.0),
  //       child: SearchableDropdown.single(
  //         items: _placeModel.researchCategoryList,
  //         value: _categoryField,
  //         hint: "Pilih Kategori riset",
  //         searchHint: "Pilih Kategori riset",
  //         onChanged: (value) {
  //           _categoryField = value;
  //         },
  //         isExpanded: true,
  //         isCaseSensitiveSearch: false,
  //       ),
  //     ),
  //   );
  // }


  // Widget _emailFormField() {
  //   return Container(
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(15.0),
  //       ),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           blurRadius: 0.5,
  //           spreadRadius: 2.0,
  //           offset: Offset(0.0, 0.0), // shadow direction: bottom right
  //         )
  //       ],
  //     ),
  //     width: _maxWidth,
  //     height: _maxWidth / 6,
  //     child: Padding(
  //       padding: const EdgeInsets.all(11.0),
  //       child: TextFormField(
  //         decoration: InputDecoration(
  //           hintStyle: Theme.of(context).textTheme.bodyText2,
  //           hintText: 'Masukkan email riset',
  //           border: InputBorder.none,
  //         ),
  //         maxLines: 1,
  //         onChanged: (value) => _emailField = value,
  //         onSaved: (newValue) => _emailField = newValue,
  //         textAlign: TextAlign.start,
  //         style: Theme.of(context).textTheme.bodyText1,
  //         autocorrect: false,
  //         keyboardType: TextInputType.emailAddress,
  //       ),
  //     ),
  //   );
  // }




  // Widget _phoneNumberFormField() {
  //   return Container(
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(15.0),
  //       ),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           blurRadius: 0.5,
  //           spreadRadius: 2.0,
  //           offset: Offset(0.0, 0.0), // shadow direction: bottom right
  //         )
  //       ],
  //     ),
  //     width: _maxWidth,
  //     height: _maxWidth / 6,
  //     child: Padding(
  //       padding: const EdgeInsets.all(11.0),
  //       child: TextFormField(
  //         decoration: InputDecoration(
  //           hintStyle: Theme.of(context).textTheme.bodyText2,
  //           hintText: 'Masukkan nomor telepon riset',
  //           border: InputBorder.none,
  //         ),
  //         maxLines: 1,
  //         onChanged: (value) => _phoneNumberField = value,
  //         onSaved: (newValue) => _phoneNumberField = newValue,
  //         textAlign: TextAlign.start,
  //         style: Theme.of(context).textTheme.bodyText1,
  //         autocorrect: false,
  //         keyboardType: TextInputType.phone,
  //         inputFormatters: [phoneNumberFormatter],
  //       ),
  //     ),
  //   );
  // }

  // Widget _nameFormField() {
  //   return Container(
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(15.0),
  //       ),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           blurRadius: 0.5,
  //           spreadRadius: 2.0,
  //           offset: Offset(0.0, 0.0), // shadow direction: bottom right
  //         )
  //       ],
  //     ),
  //     width: _maxWidth,
  //     height: _maxWidth / 6,
  //     child: Padding(
  //       padding: const EdgeInsets.all(11.0),
  //       child: TextFormField(
  //         decoration: InputDecoration(
  //           hintStyle: Theme.of(context).textTheme.bodyText2,
  //           hintText: 'Masukkan judul riset',
  //           border: InputBorder.none,
  //         ),
  //         maxLines: 1,
  //         onChanged: (value) => _nameField = value,
  //         onSaved: (newValue) => _nameField = newValue,
  //         textAlign: TextAlign.start,
  //         style: Theme.of(context).textTheme.bodyText1,
  //         maxLength: 30,
  //         autocorrect: false,
  //       ),
  //     ),
  //   );
  // }

  // Widget dropdownChoice(
  //     {@required List<String> data, @required Function onTap})
  // {
  //   String value;
  //
  //   return Container(
  //     width: _realWidth * 0.9,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(15.0),
  //       ),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           blurRadius: 0.5,
  //           spreadRadius: 2.0,
  //           offset: Offset(0.0, 0.0), // shadow direction: bottom right
  //         )
  //       ],
  //     ),
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           flex: 1,
  //           child: Container(
  //             margin: EdgeInsets.only(left: 10),
  //             child: Text(
  //               "Size: ",
  //               style: Theme.of(context).textTheme.subhead,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 3,
  //           child: DropdownButton<String>(
  //             isExpanded: true,
  //             hint: Text(
  //               "Please Select          ",
  //               style: TextStyle(
  //                 fontSize: 14,
  //               ),
  //             ),
  //             items: <String>[
  //               'Skinless Boneless, Full Loins',
  //               'brown',
  //               'silver'
  //             ].map((data) {
  //               return DropdownMenuItem(
  //                 child: new Text(data,
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                     )),
  //                 value: data,
  //               );
  //             }).toList(),
  //             onChanged: onTap,
  //             value: value,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
