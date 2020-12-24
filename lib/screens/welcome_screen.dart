import 'package:energi_kolaborasi/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, RouteHandler.AUTH);
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/welcome/$assetName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.headline6,
      bodyTextStyle: Theme.of(context).textTheme.caption,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Riset",
          body:
              "Pendanaan, pembimbingan, dan juga untuk publikasi karya riset yang telah dilaksanakan",
          image: _buildImage('1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Pendanaan",
          body: "Menyediakan fasilitas berbentuk sumberdaya, dan keuangan",
          image: _buildImage('2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Startup",
          body: "Menyediakan fasilitas berbentuk inkubasi dan akselerasi",
          image: _buildImage('3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Konsultasi",
          body:
              "Menyediakan jasa kepenasihatan dalam penyusunan maupun pembentukan proyek",
          image: _buildImage('4.jpg'),
          decoration: pageDecoration,
        ),
        // PageViewModel(
        //   title: "Title of last page",
        //   bodyWidget: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const [
        //       Text("Click on ", style: bodyStyle),
        //       Icon(Icons.edit),
        //       Text(" to edit a post", style: bodyStyle),
        //     ],
        //   ),
        //   image: _buildImage('img1'),
        //   decoration: pageDecoration,
        // ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: Row(
        children: [Text('Next'), Icon(Icons.arrow_forward)],
      ),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
