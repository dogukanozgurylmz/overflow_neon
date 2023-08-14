// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_overflow/data/repository/auth_repository.dart';
import 'package:neon_overflow/data/repository/user_repository.dart';
import 'package:neon_overflow/presentation/signin/cubit/signin_cubit.dart';

class SignInView extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();
  SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        authRepository: _authRepository,
        userRepository: _userRepository,
      ),
      child: BlocBuilder<SigninCubit, SigninState>(
        builder: (context, state) {
          var cubit = context.read<SigninCubit>();
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: cubit.emailController,
                    decoration: const InputDecoration(labelText: 'E-posta'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: cubit.passwordController,
                    decoration: const InputDecoration(labelText: 'Şifre'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  state.status == SignInStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            await cubit.submit();
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushReplacementNamed(context, "/");
                            });
                          },
                          child: const Text('Giriş Yap'),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
