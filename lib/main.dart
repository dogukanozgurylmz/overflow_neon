import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neon_overflow/core/getit/getit.dart';
import 'package:neon_overflow/presentation/add_question/add_question_view.dart';
import 'package:neon_overflow/presentation/main_view.dart';
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
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      initialRoute: "/",
      routes: {
        '/home': (context) {
          context.read<SidebarProvider>().setSelectedIndex(0);
          context.read<SidebarProvider>().setStatus(SidebarStatus.home);
          return const MainView();
        },
        '/categories': (context) {
          context.read<SidebarProvider>().setSelectedIndex(1);
          context.read<SidebarProvider>().setStatus(SidebarStatus.categories);
          return const MainView();
        },
        '/notification': (context) {
          context.read<SidebarProvider>().setSelectedIndex(2);
          context
              .read<SidebarProvider>()
              .setStatus(SidebarStatus.notifications);
          return const MainView();
        },
        '/favorites': (context) {
          context.read<SidebarProvider>().setSelectedIndex(3);
          context.read<SidebarProvider>().setStatus(SidebarStatus.favorites);
          return const MainView();
        },
        '/myquestions': (context) {
          context.read<SidebarProvider>().setSelectedIndex(4);
          context.read<SidebarProvider>().setStatus(SidebarStatus.myquestions);
          return const MainView();
        },
        '/settings': (context) {
          context.read<SidebarProvider>().setSelectedIndex(5);
          context.read<SidebarProvider>().setStatus(SidebarStatus.settings);
          return const MainView();
        },
        '/signin': (context) => SignInView(),
        '/addquestion': (context) => AddQuestionView(),
      },
    );
  }
}
