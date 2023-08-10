import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neon_overflow/core/getit/getit.dart';
import 'package:neon_overflow/presentation/add_question/add_question_view.dart';
import 'package:neon_overflow/presentation/home/home_view.dart';
import 'package:neon_overflow/presentation/main_view.dart';
import 'package:neon_overflow/presentation/provider/route_provider.dart';
import 'package:neon_overflow/presentation/question_details/question_detail_view.dart';
import 'package:neon_overflow/presentation/signin/signin_view.dart';
import 'package:neon_overflow/presentation/splash/splash_view.dart';
import 'package:neon_overflow/presentation/widgets/sidebar/sidebar_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setPathUrlStrategy();
  setup();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SidebarProvider()),
    ChangeNotifierProvider(create: (_) => RouteProvider()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var routeProvider = context.watch<RouteProvider>();
    var sidebarProvider = context.read<SidebarProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      routes: {
        '/home': (context) {
          sidebarProvider.setSelectedIndex(0);
          sidebarProvider.setStatus(SidebarStatus.home);
          return const MainView();
        },
        '/categories': (context) {
          sidebarProvider.setSelectedIndex(1);
          sidebarProvider.setStatus(SidebarStatus.categories);
          return const MainView();
        },
        '/notification': (context) {
          sidebarProvider.setSelectedIndex(2);
          context
              .read<SidebarProvider>()
              .setStatus(SidebarStatus.notifications);
          return const MainView();
        },
        '/favorites': (context) {
          sidebarProvider.setSelectedIndex(3);
          sidebarProvider.setStatus(SidebarStatus.favorites);
          return const MainView();
        },
        '/myquestions': (context) {
          sidebarProvider.setSelectedIndex(4);
          sidebarProvider.setStatus(SidebarStatus.myquestions);
          return const MainView();
        },
        '/settings': (context) {
          sidebarProvider.setSelectedIndex(5);
          sidebarProvider.setStatus(SidebarStatus.settings);
          return const MainView();
        },
        '/signin': (context) => SignInView(),
        '/addquestion': (context) => AddQuestionView(),
        '/questiondetails/${routeProvider.questionId}': (context) =>
            const QuestionDetailsView(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/questiondetails/${routeProvider.questionId}') {
          return MaterialPageRoute(
            builder: (context) {
              return QuestionDetailsView();
            },
          );
        }
        return null;
      },
    );
  }
}
