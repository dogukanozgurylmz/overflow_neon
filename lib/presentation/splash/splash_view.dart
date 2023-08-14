import 'package:flutter/material.dart';
import 'package:neon_overflow/data/repository/auth_repository.dart';
import 'package:neon_overflow/presentation/main_view.dart';
import 'package:neon_overflow/presentation/signin/signin_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AuthRepository _authRepository = AuthRepository();
  @override
  void initState() {
    super.initState();
    toDirect();
  }

  void toDirect() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_authRepository.currentUser != null) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/signin");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
