import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/article_model.dart';
import 'models/project_model.dart';
import 'screens/explore/collaboration/find_partner_screen.dart';
import 'screens/explore/collaboration/find_team_screen.dart';
import 'screens/explore/research/research_detail_screen.dart';
import 'screens/news/news_detail_screen.dart';
import 'screens/news/news_list_screen.dart';
import 'screens/project/project_list_screen.dart';
import 'screens/project/project_register_screen.dart';
import 'utils/router.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == "MainPage") {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Energi Kolaborasi',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black54,
          ),
          centerTitle: true,
          color: Colors.white,
          textTheme: Theme.of(context).textTheme,
          elevation: 1.0,
        ),
        floatingActionButtonTheme:
            Theme.of(context).floatingActionButtonTheme.copyWith(
                  backgroundColor: Color(0xffd3a93b),
                ),
        brightness: Brightness.light,
        primaryColor: Color(0xffd3a93b),
        accentColor: Color(0xffd6c07f),
        backgroundColor: Colors.white54,
        scaffoldBackgroundColor: Color(0xffF7F9F9),
        // scaffoldBackgroundColor: Colors.white,
        textTheme:
            GoogleFonts.openSansTextTheme(Theme.of(context).textTheme).copyWith(
          headline1: GoogleFonts.openSans(
            color: Color(0xffd3a93b),
            fontSize: 44.0,
            fontWeight: FontWeight.w900,
          ),

          headline2: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 36.0,
            fontWeight: FontWeight.w800,
          ),

          headline3: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),

          headline4: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 26.0,
            fontWeight: FontWeight.w600,
          ),

          headline5: GoogleFonts.openSans(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),

          headline6: GoogleFonts.openSans(
            color: Colors.black87,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
          ),

          subtitle1: GoogleFonts.openSans(
            color: Colors.black54,
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),

          subtitle2: GoogleFonts.openSans(
            color: Colors.black38,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
          ),

          // For article
          // headline5: GoogleFonts.roboto(color: Colors.black54),
          // For article
          bodyText1: GoogleFonts.openSans(color: Colors.black, fontSize: 13.0),
          bodyText2:
              GoogleFonts.openSans(color: Colors.black54, fontSize: 12.0),
          caption: GoogleFonts.openSans(
            color: Colors.black54,
            fontSize: 12.0,
          ),
        ),

        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      // End of Theme

      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),

      routes: RouteHandler.route(),
      initialRoute: RouteHandler.ROOT,
      builder: EasyLoading.init(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name.contains(RouteHandler.NEWS_DETAIL) &&
            settings.arguments != null) {
          final ArticleModel articleModel = settings.arguments;
          return CustomRoute<bool>(
              builder: (_) => NewsDetailScreen(
                    articleModel: articleModel,
                  ));
        }

        if (settings.name.contains(RouteHandler.RESEARCH_DETAIL_SCREEN) &&
            settings.arguments != null) {
          final ProjectModel model = settings.arguments;
          return CustomRoute<bool>(
              builder: (_) => ResearchDetailScreen(
                    researchModel: model,
                  ));
        }

        if (settings.name.contains(RouteHandler.NEWS_LIST) &&
            settings.arguments != null) {
          final String category = settings.arguments;
          return CustomRoute<bool>(
              builder: (_) => NewsListScreen(
                    category: category,
                  ));
        }


        if (settings.name.contains(RouteHandler.PROGRESS_RESEARCH)) {
          return CustomRoute<bool>(
              builder: (_) => ProjectListScreen(
                type: ProjectListType.research,
              ));
        }

        if (settings.name.contains(RouteHandler.PROGRESS_CONSULTATION)) {
          return CustomRoute<bool>(
              builder: (_) => ProjectListScreen(
                type: ProjectListType.consultation,
              ));
        }


        if (settings.name.contains(RouteHandler.PROGRESS_FUNDING)) {
          return CustomRoute<bool>(
              builder: (_) => ProjectListScreen(
                type: ProjectListType.funding,
              ));
        }


        if (settings.name.contains(RouteHandler.PROGRESS_STARTUP)) {
          return CustomRoute<bool>(
              builder: (_) => ProjectListScreen(
                type: ProjectListType.startup,
              ));
        }


        // if (settings.name.contains(RouteHandler.PROJECT_REGISTER) &&
        //     settings.arguments != null) {
        //   final bool isStartup = settings.arguments;
        //   return CustomRoute<bool>(
        //       builder: (_) => ProjectRegisterScreen(isStartup: isStartup));
        // }

        if (settings.name.contains(RouteHandler.FIND_RESEARCH_PARTNER)) {
          return CustomRoute<bool>(builder: (_) => FindPartnerScreen(0));
        }
        if (settings.name.contains(RouteHandler.FIND_STARTUP_PARTNER)) {
          return CustomRoute<bool>(builder: (_) => FindPartnerScreen(1));
        }

        if (settings.name.contains(RouteHandler.FIND_RESEARCH_TEAM)) {
          return CustomRoute<bool>(builder: (_) => FindTeamScreen(0));
        }
        if (settings.name.contains(RouteHandler.FIND_STARTUP_TEAM)) {

          return CustomRoute<bool>(builder: (_) => FindTeamScreen(1));
        }

        return null;
      },
    );
  }
}
