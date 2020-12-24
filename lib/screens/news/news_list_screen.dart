import 'package:flutter/material.dart';
import 'package:energi_kolaborasi/widgets/feature_button.dart';
import 'package:energi_kolaborasi/models/article_model.dart';
import 'package:energi_kolaborasi/utils/router.dart';

class NewsListScreen extends StatefulWidget {
  final String category;

  NewsListScreen({this.category});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
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

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    _calculateSize(context);

    energyArticles.forEach((element) {
      if (element.category == widget.category) countAvailableArticle();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: Theme.of(context).textTheme.headline6,
        ),
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

              Container(
                alignment: Alignment.centerLeft,
                width: _realWidth,
                padding: EdgeInsets.only(
                    left: _realWidth * 0.05,
                    right: _realWidth * 0.05,
                    bottom: _realHeight * 0.025),
                child: _count == 0
                    ? Text(
                        'Tidak ada berita dengan kategori ${widget.category}',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.start,
                      )
                    : Text('Total berita :   $_count artikel',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.start),
              ),

              SizedBox(
                height: _realHeight * 0.03,
              ),

              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: energyArticles.length,
                itemBuilder: (BuildContext context, int index) {
                  if (energyArticles[index].category != widget.category) {
                    return SizedBox();
                  }

                  return Padding(
                    padding: EdgeInsets.only(
                        left: _realWidth * 0.05,
                        right: _realWidth * 0.05,
                        bottom: _realHeight * 0.025),
                    child: featureBanner(
                      context: context,
                      background: AssetImage(energyArticles[index].bannerUrl),
                      title: energyArticles[index].title,
                      icon: Icons.circle,
                      baseWidth: _realWidth,
                      baseHeight: _realHeight,
                      route: RouteHandler.NEWS_DETAIL,
                      arguments: energyArticles[index],
                    ),
                  );
                },
              ),
              SizedBox(
                height: _realHeight * 0.06,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void countAvailableArticle() {
    setState(() {
      _count++;
    });
  }
}
