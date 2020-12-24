import 'package:energi_kolaborasi/utils/function.dart';
import 'package:flutter/material.dart';
import 'package:energi_kolaborasi/models/article_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class NewsDetailScreen extends StatefulWidget {
  final ArticleModel articleModel;
  final String title = 'Berita';

  NewsDetailScreen({this.articleModel});

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  bool _initialized = false;
  bool _firstTime = true;

  double _realWidth;
  double _realHeight;
  double _mediaWidth;
  double _mediaHeight;
  bool _perfectRatio = true;


  @override
  void initState() {

    _initializeData();

    super.initState();
  }

  void _checkSize() {
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkSize();

    if (!_initialized) {

      if (!EasyLoading.isShow) {
        EasyLoading.show(status: 'Mohon Tunggu', dismissOnTap: false);
      }

      setState(() {
        _firstTime = false;
      });
    }

    if (EasyLoading.isShow && !_firstTime) EasyLoading.dismiss();

    return Container(
      color: _perfectRatio ? Colors.white : Colors.black12,
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
              title: Text(
                widget.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.topCenter,
                  width: _realWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _realWidth * 0.055),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: _realWidth * 0.03,
                              ),

                              Text(
                                widget.articleModel.title,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(
                                height: _realWidth * 0.04,
                              ),
                              //

                              Text(
                                widget.articleModel.author +
                                    ' - ' +
                                    widget.articleModel.department,
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: _realWidth * 0.015,
                              ),

                              Text(
                                DateFormat('EEEE, d MMM yyyy')
                                    .format(widget.articleModel.publishTime),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                height: _realWidth * 0.01,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _realWidth * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          image: DecorationImage(
                            image: AssetImage(widget.articleModel.bannerUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: _realWidth,
                        height: _realWidth * 9 / 16,
                      ),
                      SizedBox(
                        height: _realWidth * 0.04,
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _realWidth * 0.055),
                          child: Text(
                            widget.articleModel.content,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _realWidth * 0.08,
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

  void _initializeData() {
    setState(() {
      _initialized = true;
    });
  }
}
