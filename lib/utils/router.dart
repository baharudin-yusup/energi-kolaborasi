

import 'package:energi_kolaborasi/first_create_screen.dart';
import 'package:energi_kolaborasi/screens/auth/auth_screen.dart';
import 'package:energi_kolaborasi/screens/auth/register_form_screen.dart';
import 'package:energi_kolaborasi/screens/auth/uncompleted_data_screen.dart';
import 'package:energi_kolaborasi/screens/explore/collaboration/collaboration_list.dart';
import 'package:energi_kolaborasi/screens/explore/consultation/consultation_screen.dart';
import 'package:energi_kolaborasi/screens/explore/explore_screen.dart';
import 'package:energi_kolaborasi/screens/explore/funding/funding_screen.dart';
import 'package:energi_kolaborasi/screens/explore/research/research_screen.dart';
import 'package:energi_kolaborasi/screens/explore/startup/startup_screen.dart';
import 'package:energi_kolaborasi/screens/home_screen.dart';
import 'package:energi_kolaborasi/screens/inbox/inbox_screen.dart';
import 'package:energi_kolaborasi/screens/news/news_screen.dart';
import 'package:energi_kolaborasi/screens/profile/profile_edit_screen_web.dart';
import 'package:energi_kolaborasi/screens/profile/profile_screen.dart';
import 'file:///D:/Projects/release/energi_kolaborasi/lib/screens/explore/collaboration/collaboration_option_screen.dart';
import 'package:energi_kolaborasi/screens/project/create_project_option_screen.dart';
import 'package:energi_kolaborasi/screens/project/project_collaboration_screen.dart';
import 'package:energi_kolaborasi/screens/project/project_list_screen.dart';
import 'package:energi_kolaborasi/screens/project/project_progress_screen.dart';
import 'package:energi_kolaborasi/screens/project/project_register_screen.dart';
import 'package:energi_kolaborasi/screens/project/timeline_screen.dart';
import 'package:energi_kolaborasi/screens/splash_screen.dart';
import 'package:energi_kolaborasi/screens/success_screen.dart';
import 'package:energi_kolaborasi/screens/welcome_screen.dart';
import 'package:energi_kolaborasi/trial_screen.dart';
import 'package:flutter/widgets.dart';

class RouteHandler {
  static const String TRIAL = '/trial';

  static const String RESEARCH_REGISTER = RESEARCH + '/register';

  static const String PROGRESS_RESEARCH = RESEARCH + '/progress';
  static const String PROGRESS_CONSULTATION = CONSULTATION + '/progress';
  static const String PROGRESS_FUNDING = FUNDING + '/progress';
  static const String PROGRESS_STARTUP = STARTUP + '/progress';

  static const String PROGRESS_STARTUP_FIND_PARTNER = COLLABORATION + '/progress/startup/partner';
  static const String PROGRESS_STARTUP_FIND_TEAM = COLLABORATION + '/progress/startup/team';

  static const String PROGRESS_RESEARCH_FIND_PARTNER = COLLABORATION + '/progress/research/partner';
  static const String PROGRESS_RESEARCH_FIND_TEAM = COLLABORATION + '/progress/research/team';

  static const String ROOT = '/';

  static const String HOME = '/home';



  static const String EXPLORE = '/explore';
  static const String NEWS = '/news';
  static const String INBOX = '/inbox';

  static const String PROFILE = '/profile';
  static const String PROFILE_CONSULTANT = PROFILE + '/consultant';
  static const String PROFILE_INVESTOR = PROFILE + '/investor';
  static const String PROFILE_APPLICANT = PROFILE + '/applicant';
  static const String PROFILE_APPLICANT_WEB = PROFILE + '/applicant-web';

  static const String RESEARCH = '/research';
  static const String RESEARCH_LIST = RESEARCH + '/list';

  static const String PROJECT = '/project';
  static const String PROJECT_LIST = PROJECT + '/list';


  static const String CONSULTATION = '/consultation';
  static const String FUNDING = '/funding';
  static const String STARTUP = '/startup';
  static const String STARTUP_LIST = STARTUP + '/list';

  static const String CREATE_PROJECT = EXPLORE + '/create-project';

  static const String TIMELINE = EXPLORE + '/timeline';
  static const String TIMELINE_RESEARCH = RESEARCH + '/timeline';
  static const String TIMELINE_CONSULTATION = CONSULTATION + '/timeline';
  static const String TIMELINE_FUNDING = FUNDING + '/timeline';
  static const String TIMELINE_STARTUP = STARTUP + '/timeline';

  static const String LOGIN = '/login';
  static const String AUTH = '/auth';

  static const String PROGRESS = '/progress';
  static const String COLLABORATION = '/collaboration';

  static const String NEWS_DETAIL = NEWS + '/detail';
  static const String NEWS_LIST = NEWS + '/list';

  static const String WELCOME = '/welcome';

  static const String FIRST_CREATE = '/first-create';
  static const String REGISTER_FORM = '/register-form';
  static const String SUCCESS = '/success-form';

  static const String CREATE_PROJECT_OPTION = '/project-form';
  static const String COLLABORATION_OPTION = '/collaboration-option';

  static const String PROJECT_REGISTER = PROJECT + '/register';

  static const String RESEARCH_DETAIL_SCREEN = RESEARCH + '/detail';

  static const String FIND_RESEARCH_TEAM = RESEARCH + '/find-team';
  static const String FIND_STARTUP_TEAM = STARTUP + '/find-team';

  static const String FIND_RESEARCH_PARTNER = RESEARCH + '/find-partner';
  static const String FIND_STARTUP_PARTNER = STARTUP + '/find-partner';


  static const String UNCOMPLETED_DATA = '/uncompleted-data';

  static const String COLLABORATION_RESEARCH = COLLABORATION + RESEARCH;
  static const String COLLABORATION_STARTUP = COLLABORATION + STARTUP;

  static const String RESEARCH_CREATE_PROJECT = RESEARCH + '/create';
  static const String STARTUP_CREATE_PROJECT = STARTUP + '/create';

  static const String CONSULTANT = '/consultant';
  static const String CONSULTANT_REGISTER = CONSULTANT + '/register';

  static const String INVESTOR = '/investor';
  static const String INVESTOR_REGISTER = INVESTOR + '/register';

  static Map<String, WidgetBuilder> route() {
    return <String, WidgetBuilder>{


      RESEARCH_LIST: (_) => ProjectListScreen(type: ProjectListType.research),
      STARTUP_LIST: (_) => ProjectListScreen(type: ProjectListType.startup),

      CONSULTANT_REGISTER: (_) => ProjectRegisterScreen(type: ProjectType.consultant,),
      INVESTOR_REGISTER: (_) => ProjectRegisterScreen(type: ProjectType.investor,),

      COLLABORATION_RESEARCH: (_) => CollaborationListScreen(type: 0,),
      COLLABORATION_STARTUP: (_) => CollaborationListScreen(type: 1,),

      RESEARCH_CREATE_PROJECT: (_) => ProjectRegisterScreen(type: ProjectType.research,),
      STARTUP_CREATE_PROJECT: (_) => ProjectRegisterScreen(type: ProjectType.startup,),


      UNCOMPLETED_DATA: (_) => UncompletedDataScreen(),

      CREATE_PROJECT_OPTION: (_) => CreateProjectOptionScreen(),
      COLLABORATION_OPTION: (_) => CollaborationOptionScreen(),

      FIRST_CREATE: (_) => FirstCreateScreen(),
      REGISTER_FORM: (_) => RegisterFormScreen(),
      SUCCESS: (_) => SuccessScreen(),

      TRIAL: (_) => TrialScreen(),
      WELCOME: (_) => WelcomeScreen(),

      LOGIN: (_) => AuthScreen(),
      AUTH: (_) => AuthScreen(),

      ROOT: (_) => SplashScreen(),

      HOME: (_) => HomeScreen(),

      PROGRESS: (_) => ProjectProgressScreen(),
      COLLABORATION: (_) => ProjectCollaborationScreen(),

      // NEWS_DETAIL: (_) => NewsDetailScreen(),
      // NEWS_LIST: (_) => NewsListScreen(),

      // HOME
      EXPLORE: (_) => ExploreScreen(),
      NEWS: (_) => NewsScreen(),
      INBOX: (_) => InboxScreen(),
      PROFILE: (_) => ProfileScreen(),

      // EXPLORE-SUB
      RESEARCH: (_) => ResearchScreen(),
      CONSULTATION: (_) => ConsultationScreen(),
      FUNDING: (_) => FundingScreen(),
      STARTUP: (_) => StartupScreen(),

      // PROJECT
      TIMELINE: (_) => TimelineScreen(0),
      TIMELINE_RESEARCH: (_) => TimelineScreen(0),
      TIMELINE_CONSULTATION: (_) => TimelineScreen(1),
      TIMELINE_FUNDING: (_) => TimelineScreen(2),
      TIMELINE_STARTUP: (_) => TimelineScreen(3),

      // RESEARCH-SUB
      // PROJECT_LIST: (_) => ProjectListScreen(),
      // RESEARCH_DETAIL_SCREEN: (_) => ResearchDetailScreen(),

      // PROFILE-SUB
      PROFILE_APPLICANT: (_) => ProfileEditScreen(),
      PROFILE_APPLICANT_WEB: (_) => ProfileEditScreenWeb(),
    };
  }
}
