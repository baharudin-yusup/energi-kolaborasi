import 'package:carousel_slider/carousel_slider.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:energi_kolaborasi/widgets/feature_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fsearch/fsearch.dart';

import 'package:energi_kolaborasi/models/article_model.dart';
import 'package:energi_kolaborasi/models/category_model.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class NewsScreen extends StatefulWidget {
  final String title = "News";

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {


  @override
  void initState() {



    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_mediaHeight != MediaQuery.of(context).size.height ||
        _mediaWidth != MediaQuery.of(context).size.width) {
      _calculateSize(context);
    }

  }

  double _realWidth =  0;
  double _realHeight = 0;
  double _mediaWidth = 0;
  double _mediaHeight = 0;
  double _maxWidth = 0;
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: _realWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: _realHeight * 0.08,
                ),

                Container(
                  width: _realWidth * 0.9,
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),

                SizedBox(
                  height: _realHeight * 0.03,
                ),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  width: _realWidth * 0.9,
                  height: _realHeight * 0.06,
                  child: FSearch(
                    hints: ['Cari Projek'],
                    width: _realHeight * 0.06,
                    height: _realHeight * 0.06,
                    backgroundColor: Colors.white,
                    style: TextStyle(
                        fontSize: 16.0, height: 1.0, color: Colors.grey),
                    margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 9.0),
                    padding: EdgeInsets.only(
                        left: 6.0, right: 6.0, top: 3.0, bottom: 3.0),
                    prefixes: [
                      const SizedBox(width: 6.0),
                      Icon(
                        Icons.search,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 3.0)
                    ],

                    /// 点击键盘搜索时触发
                    ///
                    /// Fired when you click on the keyboard to search
                    onSearch: (value) {
                      setState(() {
                        // searching1 = true;
                      });
                    },
                  ),
                ),

                SizedBox(
                  height: _realHeight * 0.03,
                ),

                // Top News
                CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int itemIndex) =>
                      featureBanner(
                    background: AssetImage(energyArticles[itemIndex].bannerUrl),
                    title: energyArticles[itemIndex].title,
                    icon: Icons.add_circle_outline,
                    baseWidth: _realWidth,
                    baseHeight: _realHeight,
                    size: FeatureSize.medium,
                    context: context,
                    route: RouteHandler.NEWS_DETAIL,
                    arguments: energyArticles[itemIndex],
                  ),
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 10),
                    autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                ),

                SizedBox(
                  height: _realHeight * 0.03,
                ),

                // Category Text
                Container(
                  width: _realWidth * 0.9,
                  child: Text(
                    "Kategori",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),

                SizedBox(
                  height: _realHeight * 0.01,
                ),

                // Category Icon
                Container(
                  width: _realWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      featureButton(
                        route: RouteHandler.NEWS_LIST,
                        icon: FaIcon(FontAwesomeIcons.microscope).icon,
                        title: CategoryModel.MINERAL,
                        baseWidth: _realWidth,
                        baseHeight: _realHeight,
                        context: context,
                        arguments: CategoryModel.MINERAL,
                      ),
                      featureButton(
                        route: RouteHandler.NEWS_LIST,
                        icon: FaIcon(FontAwesomeIcons.servicestack).icon,
                        title: CategoryModel.ENERGY,
                        baseWidth: _realWidth,
                        baseHeight: _realHeight,
                        context: context,
                        arguments: CategoryModel.ENERGY,
                      ),
                      featureButton(
                        route: RouteHandler.NEWS_LIST,
                        icon: FaIcon(FontAwesomeIcons.dollarSign).icon,
                        title: CategoryModel.MINE,
                        baseWidth: _realWidth,
                        baseHeight: _realHeight,
                        context: context,
                        arguments: CategoryModel.MINE,
                      ),
                      featureButton(
                        route: RouteHandler.NEWS_LIST,
                        icon: FaIcon(FontAwesomeIcons.kickstarter).icon,
                        title: CategoryModel.OIL,
                        arguments: CategoryModel.OIL,
                        baseWidth: _realWidth,
                        baseHeight: _realHeight,
                        context: context,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: _realHeight * 0.03,
                ),

                // Featured Text
                Container(
                  width: _realWidth * 0.9,
                  child: Text(
                    "Featured",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),

                SizedBox(
                  height: _realHeight * 0.01,
                ),

                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
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
      ),
    );
  }
}
