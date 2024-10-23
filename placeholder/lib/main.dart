import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:placeholder/auth_service.dart';
import 'package:placeholder/chatbot/emergency.dart';
import 'package:placeholder/provider.dart';
import 'package:provider/provider.dart';
import 'landingpage/landingpage.dart';
import 'mainpage/mainpage.dart';
import 'mypage/list_course.dart';
import 'mypage/mypage.dart';
import 'errorpage.dart';
import 'landingpage/landingpage_web.dart';
import 'mainpage/select_location.dart';
import 'package:placeholder/mainpage/realtimecourse.dart';
import 'package:placeholder/mypage/alert-settings.dart';
import 'package:placeholder/mypage/settings_page.dart';
import 'package:placeholder/widget/test.dart';
import 'package:placeholder/chatbot/select_location_chat.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CourseLocationXY(),
      child: const MyApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPageWeb(),
      routes: [
        GoRoute(
          path: 'testserver',
          builder: (context, state) => TestApiServer(),
        ),
        GoRoute(
          path: 'main',
          builder: (context, state) => const MainPage(),
          routes: [
            GoRoute(
              path: 'location',
              builder: (context, state) => SelectLocation(),
            ),
            GoRoute(
              path: 'real',
              builder: (context, state) => const RealTimeCoursePage(),
            ),
            GoRoute(
                path: 'mypage',
                builder: (context, state) => const Mypage(),
                routes: [
                  GoRoute(
                    path: 'list',
                    builder: (context, state) => const ListCourse(),
                  ),
                  GoRoute(
                    path: 'alarm',
                    builder: (context, state) => const AlertAreaSettings(),
                  ),
                  GoRoute(
                    path: 'settings',
                    builder: (context, state) => const SettingsPage(),
                  ),
                ]),
            GoRoute(
              path: 'select',
              builder: (context, state) => ConcentricAnimationOnboarding(),
            ),
            GoRoute(
              path: 'emergency',
              builder: (context, state) => Emergency(),
            ),
          ],
        ),
        GoRoute(
          path: 'welcome',
          builder: (context, state) => const LandingPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/404',
      builder: (context, state) =>
          NotFoundPage(uri: state.extra as String? ?? ''),
    ),
  ],
  routerNeglect: true,
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

// Export the router to be used in other files
GoRouter get router => _router;
