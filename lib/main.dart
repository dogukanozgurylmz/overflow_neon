import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neon_overflow/presentation/main_view.dart';
import 'package:neon_overflow/presentation/widgets/sidebar/sidebar_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'presentation/home/home_view.dart';

Future<void> main() async {
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainView(),
    );
  }
}
