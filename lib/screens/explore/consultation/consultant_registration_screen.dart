import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:energi_kolaborasi/widgets/abstract_card.dart';
import 'package:energi_kolaborasi/widgets/abstract_button.dart';

class ConsultantRegistrationScreen extends StatefulWidget {
  final String title = 'Menjadi Konsultan';

  @override
  _ConsultantRegistrationScreenState createState() =>
      _ConsultantRegistrationScreenState();
}

class _ConsultantRegistrationScreenState
    extends State<ConsultantRegistrationScreen> {
  double _realWidth = 0;
  double _maxWidth = 0;
  double _realHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  void _calculateSize(BuildContext context) {
    // Resolution 16:9

    if (MediaQuery.of(context).size.width <
        MediaQuery.of(context).size.height) {
      _realWidth = MediaQuery.of(context).size.width;
      _realHeight = MediaQuery.of(context).size.height;
      _maxWidth = _realWidth * 0.9;
    } else {
      _realHeight = MediaQuery.of(context).size.height;
      _realWidth = _realHeight * (9 / 16);
      _maxWidth = _realWidth * 0.9;
    }
  }

  @override
  Widget build(BuildContext context) {
    _calculateSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: _realWidth * 0.05,
            right: _realWidth * 0.05,
            top: _realWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _realWidth * 0.03,
            ),
            // Headline 5
            Text(
              'Berkas',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: _realWidth * 0.03,
            ),
            Text(
              'Mohon lengkapi data-data berikut untuk mengajukan diri sebagai konsultan',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: _realWidth * 0.08,
            ),

            // KTP Form
            Text(
              'KTP',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: _realWidth * 0.03,
            ),
            GestureDetector(
              onTap: () {
                print('tes');
              },
              child: AbstractCard(
                size: _maxWidth,
                leading: Text(
                  'Upload disini dengan format PDF max. 20 MB',
                  maxLines: 3,
                ),
              ),
            ),
            SizedBox(
              height: _realWidth * 0.06,
            ),

            // Kartu Tanda Pengenal Institusi Form
            Text(
              'Kartu Tanda Pengenal Institusi',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: _realWidth * 0.03,
            ),
            GestureDetector(
              onTap: () {
                print('tes');
              },
              child: AbstractCard(
                size: _maxWidth,
                leading: Text(
                  'Upload disini dengan format PDF max. 20 MB',
                  maxLines: 3,
                ),
              ),
            ),
            SizedBox(
              height: _realWidth * 0.06,
            ),

            // Kartu Tanda Pengenal Institusi Form
            Text(
              'Surat Rekomendasi Institusi',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: _realWidth * 0.03,
            ),
            GestureDetector(
              onTap: () {
                print('tes');
              },
              child: AbstractCard(
                size: _maxWidth,
                leading: Text(
                  'Upload disini dengan format PDF max. 20 MB',
                  maxLines: 3,
                ),
              ),
            ),
            SizedBox(
              height: _realWidth * 0.2,
            ),

            RaisedButton(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 0.0,
              padding: EdgeInsets.all(0.0),
              onPressed: () {},
              child: AbstractButton(
                size: _maxWidth,
                title: 'Submit',
              ),
            ),
            SizedBox(
              height: _realWidth * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
