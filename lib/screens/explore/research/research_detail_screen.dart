import 'package:energi_kolaborasi/models/project_model.dart';
import 'package:energi_kolaborasi/widgets/abstract_card.dart';
import 'package:energi_kolaborasi/widgets/data_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResearchDetailScreen extends StatefulWidget {
  final ProjectModel researchModel;

  final String title = 'Detail Riset';

  const ResearchDetailScreen({Key key, this.researchModel}) : super(key: key);

  @override
  _ResearchDetailScreenState createState() => _ResearchDetailScreenState();
}

class _ResearchDetailScreenState extends State<ResearchDetailScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _sameRatio == true ? Colors.white : Colors.black12,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: _realWidth * 0.11,),

                    // Title
                    DataView(
                        leadingIcon: FontAwesomeIcons.bookOpen,
                        trailingIcon: null,
                        title: 'Judul Riset',
                        value: widget.researchModel.title,
                        realWidth: _realWidth,
                        maxWidth: _maxWidth,
                        onTap: () {}),
                    SizedBox(height: _realWidth * 0.15,),

                    // Institution
                    DataView(
                        leadingIcon: FontAwesomeIcons.school,
                        trailingIcon: null,
                        title: 'Asal Institusi',
                        value: widget.researchModel.institution,
                        realWidth: _realWidth,
                        maxWidth: _maxWidth,
                        onTap: () {}),
                    SizedBox(height: _realWidth * 0.15,),

                    // Category
                    DataView(
                        leadingIcon: FontAwesomeIcons.researchgate,
                        trailingIcon: null,
                        title: 'Bidang Riset',
                        value: widget.researchModel.category,
                        realWidth: _realWidth,
                        maxWidth: _maxWidth,
                        onTap: () {}),
                    SizedBox(height: _realWidth * 0.15,),

                    // Email
                    DataView(
                        leadingIcon: FontAwesomeIcons.at,
                        trailingIcon: null,
                        title: 'Email Pengaju',
                        value: widget.researchModel.email,
                        realWidth: _realWidth,
                        maxWidth: _maxWidth,
                        onTap: () {}),
                    SizedBox(height: _realWidth * 0.15,),

                    // Abstract Form
                    Text(
                      'Abstrak Penelitian',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: _realWidth * 0.03,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // PlatformFile file = await selectFile();
                        // storageUploadSingeFile('research/wteSst1', file.path);

                        // print('OUR URL => $downloadUrl');

                      },
                      child: AbstractCard(
                        size: _maxWidth,
                        leading: Text(
                          'Klik untuk mengunduh file ini',
                          maxLines: 3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _realWidth * 0.06,
                    ),

                    // Abstract Form
                    Text(
                      'Desain Teknik',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: _realWidth * 0.03,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // PlatformFile file = await selectFile();
                        // storageUploadSingeFile('research/wteSst1', file.path);

                        // print('OUR URL => $downloadUrl');

                      },
                      child: AbstractCard(
                        size: _maxWidth,
                        leading: Text(
                          'Klik untuk mengunduh file ini',
                          maxLines: 3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _realWidth * 0.06,
                    ),

                    // RAB Form
                    Text(
                      'RAB Riset',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: _realWidth * 0.03,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // PlatformFile file = await selectFile();
                        // storageUploadSingeFile('research/wteSst1', file.path);

                        // print('OUR URL => $downloadUrl');

                      },
                      child: AbstractCard(
                        size: _maxWidth,
                        leading: Text(
                          'Klik untuk mengunduh file ini',
                          maxLines: 3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _realWidth * 0.16,
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
