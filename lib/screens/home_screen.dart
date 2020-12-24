import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:energi_kolaborasi/models/place_model.dart';
import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:energi_kolaborasi/screens/explore/explore_screen.dart';
import 'package:energi_kolaborasi/screens/inbox/inbox_screen.dart';
import 'package:energi_kolaborasi/screens/news/news_screen.dart';
import 'package:energi_kolaborasi/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class HomeScreen extends StatefulWidget {
  final String title = 'Home Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    print('INIT [${widget.title}]');

    _initUser();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        });
      }
    } else {
      if (_mediaHeight != MediaQuery.of(context).size.height ||
          _mediaWidth != MediaQuery.of(context).size.width) {
        _mediaHeight = MediaQuery.of(context).size.height;
        _mediaWidth = MediaQuery.of(context).size.width;

        setState(() {
          _realWidth = _mediaWidth;
          _realHeight = _mediaHeight;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        color: _sameRatio == true ? Colors.white : Colors.black12,
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
              body: SizedBox.expand(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    if (_currentIndex != index) {
                      setState(() => _currentIndex = index);
                    }
                  },
                  children: <Widget>[
                    ExploreScreen(),
                    NewsScreen(),
                    InboxScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavyBar(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                iconSize: 30.0,
                backgroundColor: Theme.of(context).primaryColor,
                containerHeight: 63.0,
                selectedIndex: _currentIndex,
                onItemSelected: (index) {
                  setState(() => _currentIndex = index);
                  _pageController.jumpToPage(index);
                },
                items: <BottomNavyBarItem>[
                  BottomNavyBarItem(
                    title: Text('Explore'),
                    icon: Icon(Icons.explore),
                    inactiveColor: Colors.black54,
                    activeColor: Colors.black87,
                  ),
                  BottomNavyBarItem(
                    title: Text('News'),
                    icon: Icon(Icons.menu_book_outlined),
                    inactiveColor: Colors.black54,
                    activeColor: Colors.black87,
                  ),
                  BottomNavyBarItem(
                    title: Text('Inbox'),
                    icon: Icon(Icons.inbox_rounded),
                    inactiveColor: Colors.black54,
                    activeColor: Colors.black87,
                  ),
                  BottomNavyBarItem(
                    title: Text('Profile'),
                    icon: Icon(Icons.person),
                    inactiveColor: Colors.black54,
                    activeColor: Colors.black87,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _initialized = false;
  bool _isCompleted;

  Future<void> _initUser() async {
    _isCompleted =
        await UserModel.isCompleteData();

    setState(() {
      _initialized = true;
    });
  }
}
