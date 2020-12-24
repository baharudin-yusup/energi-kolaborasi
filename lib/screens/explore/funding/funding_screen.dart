import 'package:energi_kolaborasi/widgets/feature_button.dart';
import 'package:energi_kolaborasi/widgets/inner_header.dart';
import 'package:flutter/material.dart';

class FundingScreen extends StatefulWidget {
  final String title = 'Pendanaan';
  @override
  _FundingScreenState createState() => _FundingScreenState();
}

class _FundingScreenState extends State<FundingScreen> {
  double _realWidth = 0;
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
    } else {
      _realHeight = MediaQuery.of(context).size.height;
      _realWidth = _realHeight * (9 / 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    _calculateSize(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black54,
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: _realWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: _realHeight * 0.03,
              ),
              innerHeader(
                background: AssetImage('assets/images/explore-create.jpg'),
                title: 'Pendanaan',
                subtitle:
                'Menyediakan fasilitas berbentuk sumber daya dan keuangan',
                baseWidth: _realWidth,
                baseHeight: _realHeight,
                size: FeatureSize.big,
              ),

              SizedBox(height: _realWidth * 0.1,),

              InkWell(
                child: Container(
                  width: _realWidth * 0.9,
                  height: _realHeight * 0.075,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        coloredText('Menjadi Pendana', context),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () => print('r'),
              ),

              SizedBox(height: _realWidth * 0.03,),

              InkWell(
                child: Container(
                  width: _realWidth * 0.9,
                  height: _realHeight * 0.075,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        coloredText('Lini Waktu', context),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () => print('r'),
              ),

              SizedBox(height: _realWidth * 0.03,),

              InkWell(
                child: Container(
                  width: _realWidth * 0.9,
                  height: _realHeight * 0.075,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        coloredText('Projek Terajukan', context),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () => print('r'),
              ),

              SizedBox(height: _realWidth * 0.03,),

            ],
          ),
        ),
      ),
    );
  }
}
